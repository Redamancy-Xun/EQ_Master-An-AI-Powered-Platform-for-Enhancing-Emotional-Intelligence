import { isSafari } from './common';
import createNS from './helpers/svg_elements';
import dataManager from './DataManager';
import image from '@ohos.multimedia.image';
import fs from '@ohos.file.fs';
import {LogUtil} from './LogUtil'

//类型定义参考 https://lottiefiles.github.io/lottie-docs/assets/
const SOURCE_BASE64 = /data:image\/([a-zA-Z0-9+-]+\/?);base64/;
const TYPE_IMAGE_SOURCE_RAWFILE = 0
const TYPE_IMAGE_SOURCE_BASE64 = 1

const ImagePreloader = (function () {
  var proxyImage = (function () {

    // 使用空对象替代不支持动态创建的Canvas组件
    return {  };
  }());

  function imageLoaded() {
    this.loadedAssets += 1;
    if (this.loadedAssets === this.totalImages && this.loadedFootagesCount === this.totalFootages) {
      if (this.imagesLoadedCb) {
        this.imagesLoadedCb(null);
      }
    }
  }
  function footageLoaded() {
    this.loadedFootagesCount += 1;
    if (this.loadedAssets === this.totalImages && this.loadedFootagesCount === this.totalFootages) {
      if (this.imagesLoadedCb) {
        this.imagesLoadedCb(null);
      }
    }
  }

  function getAssetsPath(assetData, assetsPath, originalPath) {
    var path = '';
    if (assetData.e) {
      path = assetData.p;
    } else if (assetsPath) {
      var imagePath = assetData.p;
      if (imagePath.indexOf('images/') !== -1) {
        imagePath = imagePath.split('/')[1];
      }
      path = assetsPath + imagePath;
    } else {
      path = originalPath;
      path += assetData.u ? assetData.u : '';
      path += assetData.p;
    }
    return path;
  }

  function testImageLoaded(img) {
    var _count = 0;
    var intervalId = setInterval(function () {
      var box = img.getBBox();
      if (box.width || _count > 500) {
        this._imageLoaded();
        clearInterval(intervalId);
      }
      _count += 1;
    }.bind(this), 50);
  }

  function generatePixelMapAndRefreshUI2(data, ob, callback) {
    let image_source = image.createImageSource(data)
    //piexlmap改成不可编辑状态，优化图形图像端读取速度
    let opts = {
        editable: false,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888
    };
    //创建pixel_map
    image_source?.createPixelMap(opts, (err, pixel_map) => {
      if (!err) {
        ob.img.pixel_map = pixel_map;
        if (ob.assetData && ob.assetData.w && ob.assetData.h) {
          ob.img.width = ob.assetData.w;
          ob.img.height = ob.assetData.h;
          callback();
        } else {
          //获取解析出来的pixel_map的宽、高
          pixel_map.getImageInfo().then((image_info) => {
            ob.img.width = image_info.size.width;
            ob.img.height = image_info.size.height;
            callback();
          });
        }
      } else {
        callback();
      }
    });
  }

  function createImageData(assetData) {
    var path = getAssetsPath(assetData, this.assetsPath, this.path);
    var img = createNS('image');
    if (isSafari) {
      this.testImageLoaded(img);
    } else {
      img.addEventListener('load', this._imageLoaded, false);
    }
    img.addEventListener('error', function () {
      ob.img = proxyImage;
      this._imageLoaded();
    }.bind(this), false);
    img.setAttributeNS('http://www.w3.org/1999/xlink', 'href', path);
    if (this._elementHelper.append) {
      this._elementHelper.append(img);
    } else {
      this._elementHelper.appendChild(img);
    }
    var ob = {
      img: img,
      assetData: assetData,
    };
    return ob;
  }

  function createImgData(assetData) {
    var path = getAssetsPath(assetData, this.assetsPath, this.path);
    var context = this.context;
    if (context == null) {
      context = getContext();
    }
    //因OpenHarmony无法通过createTag创建html中的img标签，所以这里构造一个img对象，同进添加其使用到的addEventListener方法
    var img = {
      addEventListener: function (type, callback, flag) {
        if (type === "load") {
            if (this._imageAssetDelegate) {
                this._imageAssetDelegate(path, (err, pixel_map) => {
                  if (pixel_map == null) {
                    //assetData.e值是不唯一的参数，所以由assetData.p值来判断图片资源是base64图片资源，还是外部图片资源
                    if (SOURCE_BASE64.test(assetData.p)) { //正则表达式判断是否含有data:image/;base64字段
                      readBase64(assetData, ob, callback); //base64图片
                    } else { //rawfile资源图片
                      readRawFile(context, assetData, ob, callback);
                    }
                  } else {
                    ob.img.pixel_map = pixel_map;
                    if (ob.assetData && ob.assetData.w && ob.assetData.h) {
                      ob.img.width = ob.assetData.w;
                      ob.img.height = ob.assetData.h;
                      callback();
                    } else {
                      //获取解析出来的pixel_map的宽、高
                      pixel_map.getImageInfo().then((image_info) => {
                        ob.img.width = image_info.size.width;
                        ob.img.height = image_info.size.height;
                        callback();
                      });
                    }
                  }
                });
                return;
            }
          //assetData.e值是不唯一的参数，所以由assetData.p值来判断图片资源是base64图片资源，还是外部图片资源
          if (SOURCE_BASE64.test(assetData.p)) { //正则表达式判断是否含有data:image/;base64字段
            readBase64(assetData, ob, callback); //base64图片
          } else { //rawfile资源图片
            readRawFile(context, assetData, ob, callback);
          }
        }
      }.bind(this)
    };
    var ob = {
      img: img,
      assetData: assetData,
    };
    img.crossOrigin = 'anonymous';
    img.addEventListener('load', this._imageLoaded, false);
    img.addEventListener('error', function () {
      ob.img = proxyImage;
      this._imageLoaded();
    }.bind(this), false);
    img.src = path;
    return ob;
  }

  function readBase64(assetData, ob, callback) {
    //generatePixelMapAndRefreshUI的入参ob可能为undefined，所以这里需要每隔一段时间检测一下ob是否实例化好了
    let task_id = setInterval(() => {
      if (!ob) {
        return
      }
      generatePixelMapAndRefreshUI2(assetData.p, ob, callback)
      //取消循环检测
      clearInterval(task_id)
    }, 10)
  }

  function readRawFile(context, assetData, ob, callback) {
    //拼接rawfile url
    let res = assetData.u + assetData.p; //->common/image/lottie/icon.png
    try {
      let filePath = context.filesDir + '/' + res;
      let isExist = fs.accessSync(filePath); //判断图片资源是否存在
      if (isExist) {
        let file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
        let stat = fs.statSync(filePath);
        let arrayBuffer = new ArrayBuffer(stat.size);
        fs.read(file.fd, arrayBuffer, (err, readLen) => {
          if (!!!err) {
            generatePixelMapAndRefreshUI2(arrayBuffer, ob, callback);
          } else {
            //加载依赖图片异常时，默认动画加载正常
            callback();
          }
          fs.close(file)
        })
      } else {
        //获取rawfile的字节数组数据
        context.resourceManager.getRawFileContent(res, (err, raw_file_content) => {
          if (!!!err) {
            generatePixelMapAndRefreshUI2(raw_file_content.buffer, ob, callback);
          } else {
            //加载依赖图片异常时，默认动画加载正常
            callback();
          }
        })
      }
    } catch (err) {
      LogUtil.error('Method readRawFile execute error: ' + JSON.stringify(err));
    }
  }

  function createFootageData(data) {
    var ob = {
      assetData: data,
    };
    var path = getAssetsPath(data, this.assetsPath, this.path);
    dataManager.loadData(path, function (footageData) {
      ob.img = footageData;
      this._footageLoaded();
    }.bind(this), function () {
      ob.img = {};
      this._footageLoaded();
    }.bind(this));
    return ob;
  }

  function loadAssets(assets, cb) {
    this.imagesLoadedCb = cb;
    var i;
    var len = assets.length;
    for (i = 0; i < len; i += 1) {
      if (!assets[i].layers) {
        if (this.imagePath && this.imagePath != '') {
          assets[i].u = this.imagePath;
        }
        if (!assets[i].t || assets[i].t === 'seq') {
          this.totalImages += 1;
          this.images.push(this._createImageData(assets[i]));
        } else if (assets[i].t === 3) {
          this.totalFootages += 1;
          this.images.push(this.createFootageData(assets[i]));
        }
      }
    }
  }

  function setPath(path) {
    this.path = path || '';
  }

  function setAssetsPath(path) {
    this.assetsPath = path || '';
  }

  function getAsset(assetData) {
    var i = 0;
    var len = this.images.length;
    while (i < len) {
      if (this.images[i].assetData === assetData) {
        return this.images[i].img;
      }
      i += 1;
    }
    return null;
  }

  function destroy() {
    this.imagesLoadedCb = null;
    this.images.length = 0;
  }

  function loadedImages() {
    return this.totalImages === this.loadedAssets;
  }

  function loadedFootages() {
    return this.totalFootages === this.loadedFootagesCount;
  }

  function setImageAssetDelegate(imageAssetDelegate) {
    this._imageAssetDelegate = imageAssetDelegate;
  }

  function setCacheType(type, elementHelper, context, imagePath) {
    this.context = context;
    this.imagePath = imagePath;
    if (type === 'svg') {
      this._elementHelper = elementHelper;
      this._createImageData = this.createImageData.bind(this);
    } else {
      this._createImageData = this.createImgData.bind(this);
    }
  }

  function ImagePreloaderFactory() {
    this._imageLoaded = imageLoaded.bind(this);
    this._footageLoaded = footageLoaded.bind(this);
    this._imageAssetDelegate = null;
    this.testImageLoaded = testImageLoaded.bind(this);
    this.createFootageData = createFootageData.bind(this);
    this.assetsPath = '';
    this.path = '';
    this.totalImages = 0;
    this.totalFootages = 0;
    this.loadedAssets = 0;
    this.loadedFootagesCount = 0;
    this.imagesLoadedCb = null;
    this.images = [];
    this.context = null;
    this.imagePath = '';
  }

  ImagePreloaderFactory.prototype = {
    loadAssets: loadAssets,
    setAssetsPath: setAssetsPath,
    setPath: setPath,
    loadedImages: loadedImages,
    loadedFootages: loadedFootages,
    destroy: destroy,
    getAsset: getAsset,
    createImgData: createImgData,
    createImageData: createImageData,
    imageLoaded: imageLoaded,
    footageLoaded: footageLoaded,
    setCacheType: setCacheType,
    setImageAssetDelegate: setImageAssetDelegate,
  };

  return ImagePreloaderFactory;
}());

export default ImagePreloader;
