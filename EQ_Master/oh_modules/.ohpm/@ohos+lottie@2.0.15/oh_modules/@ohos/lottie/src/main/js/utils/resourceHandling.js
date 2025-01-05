import fs from '@ohos.file.fs';
import util from '@ohos.util';
import zlib from '@ohos.zlib'
import request from "@ohos.request";
import {LogUtil} from './LogUtil'

// 筛选.json资源
const filterJson = function (way) {
  try{
  let listFileOption = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.json'], // 匹配文件后缀名为'.json'的文件
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  // 以同步方式列出文件夹下所有文件名
  let files = fs.listFileSync(way, listFileOption);
  return files.find(item => item.endsWith('.json'));
  } catch (err) {
    LogUtil.error('Method filterJson execute error: ' + JSON.stringify(err));
  }
};

// 判断解压之后的zip中是否有其他文件夹
const isHaveDirectory = function (way) {
  try{
  let listFileOption = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.json'], // 匹配文件后缀名为'.json'的文件
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  // 以同步方式列出文件夹下所有文件名
  let files = fs.listFileSync(way, listFileOption);
  for (let i = 0; i < files.length; i++) {
    let isDirectory = fs.statSync(`${way}/${files[i]}`).isDirectory();
    if (isDirectory && files[i] !== '__MACOSX' && files[i] !== 'images') {
      if (filterJson(`${way}/${files[i]}`) && isImagesDir(`${way}/${files[i]}`)) {
        return files[i];
      }
    }
  }
  } catch (err) {
    LogUtil.error('Method isHaveDirectory execute error: ' + JSON.stringify(err));
  }
  return null;
};

// 判断是否是images文件夹
const isImagesDir = function (way) {
  try{
  let listFileOption = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.json'], // 匹配文件后缀名为'.json'的文件
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  let files = fs.listFileSync(way, listFileOption);
  for (let i = 0; i < files.length; i++) {
    if (files[i] == 'images' && fs.statSync(`${way}/${files[i]}`).isDirectory() && isHaveImg(`${way}/${files[i]}`)) {
      return true;
    }
  }
  } catch (err) {
    LogUtil.error('Method isImagesDir execute error: ' + JSON.stringify(err));
  }
  return false;
}

// 移动解压之后的文件中带有文件夹的image
const moveImages = function (routerDir, way) {
  try{
  let listFileOption = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.png'], // 匹配文件后缀名为'.png'
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  // files创建新images文件夹
  let dirPath = routerDir + "/images";
  try {
    fs.mkdirSync(dirPath);
  } catch (err) {
    LogUtil.error('mkdir err:' + JSON.stringify(err));
  }
  let newWay = `${routerDir}/${way}/images`;
  let files = fs.listFileSync(newWay, listFileOption);
  for (let i = 0; i < files.length; i++) {
    let srcPath = `${newWay}/${files[i]}`;
    let destPath = `${dirPath}/${files[i]}`;
    try {
      // 移动文件
      fs.moveFileSync(srcPath, destPath);
    } catch (err) {
      LogUtil.error('Method moveImages moveFile err:' + JSON.stringify(err));
    }
  }
  } catch (err) {
    LogUtil.error('Method moveImages execute error: ' + JSON.stringify(err));
  }
};

// 移动解压之后的文件中带有文件夹的json
const moveJson = function (routerDir, way) {
  try{
  let listOptionJson = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.json'], // 匹配文件后缀名为'.json'
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  let jsonWay = `${routerDir}/${way}`;
  let jsonFile = fs.listFileSync(jsonWay, listOptionJson);
  let newJson = jsonFile.find(item => item.endsWith('.json'));
  let srcPath = `${jsonWay}/${newJson}`;
  let destPath = `${routerDir}/${newJson}`;
  try {
    // 移动文件
    fs.moveFileSync(srcPath, destPath);
  } catch (err) {
    LogUtil.error('moveJson err:' + JSON.stringify(err));
  }
  } catch (err) {
    LogUtil.error('Method moveJson execute error: ' + JSON.stringify(err));
  }
};

// 解压和读取
export const decompressAndReadJson = function (url, cacheDir, fileDir) {
  const lastIndex = url.lastIndexOf("/");
  const result = url.substring(lastIndex + 1);
  let inFile = cacheDir + '/' + result;
  let outFile = fileDir;
  let options = {
    level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
    memLevel: zlib.MemLevel.MEM_LEVEL_MAX,
    strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
  };
  return new Promise((resolve, reject) => {
    zlib.decompressFile(inFile, outFile, options).then((data) => {
      // 解压完成之后读取 json 数据
      if (isHaveDirectory(fileDir)) {
        let newFileDir = isHaveDirectory(fileDir);
        moveImages(fileDir, newFileDir);
        moveJson(fileDir, newFileDir);
        let zipData = readJson(url, fileDir);
        // 修改u路径
        let newZipData = handleZipAssets(zipData,fileDir)
        resolve(newZipData);
      } else {
        let zipData = readJson(url, fileDir);
        // 修改u路径
        let newZipData = handleZipAssets(zipData,fileDir)
        resolve(newZipData);
      }
    }).catch((errData) => {
      reject(errData);
    });
  });
};

// 判断沙箱中是否有下载的zip资源
export const isHaveZip = function (url, readPath, errCallBack) {
  try {
    const lastIndex = url.lastIndexOf("/");
    const result = url.substring(lastIndex + 1);
    // 通过沙箱中下载或者解压的文件名来找到文件所在路径
    let filePath = readPath + '/' + result;
    //同步方法判断沙箱里的文件是否存在
    let isExist = fs.accessSync(filePath);
    return isExist;
  } catch (err) {
    LogUtil.error('Method isHaveZip execute error: ' + JSON.stringify(err));
    if(errCallBack){
      errCallBack('error', err);
    }
  }
};

// 读取json数据
export const readJson = function (url, readPath, errCallBack) {
  try {
    let textDecoderOptions = util.TextDecoderOptions = {
      ignoreBOM : true
    }
    let resStr = util.TextDecoder.create('utf-8', textDecoderOptions)
    let existResult = isCacheExist(url, readPath)
    if (existResult.isExist) {
      // 打开文件
      let file = fs.openSync(existResult.filePath, fs.OpenMode.READ_ONLY);
      // 以同步方法获取文件详细属性信息
      let stat = fs.statSync(existResult.filePath);
      // 读取文件
      let arrayBuffer = new ArrayBuffer(stat.size);
      // 以同步方法从文件读取数据
      fs.readSync(file.fd, arrayBuffer);
      // 解码的json数据
      let lottieStr = resStr.decodeWithStream(new Uint8Array(arrayBuffer));
      return JSON.parse(lottieStr);
    }
  } catch (err) {
    LogUtil.error('Method readJson execute error: ' + JSON.stringify(err));
    if (errCallBack) {
      errCallBack('error', err);
    }
  }
};

// 判断沙箱里的文件是否存在
export const isCacheExist = function (url, readPath) {
  try{
  const lastIndex = url.lastIndexOf("/");
  const result = url.substring(lastIndex + 1); //最后一个斜杠后的字符串
  // 通过沙箱中下载或者解压的文件名来找到文件所在路径
  let filePath = getSuffix(url) == ('.js' || '.json') ? readPath + '/' + result : readPath + '/' + filterJson(readPath);
  //同步方法判断沙箱里的文件是否存在
  let isExist = fs.accessSync(filePath);
  return {
    isExist,
    filePath
  };
  } catch (err) {
    LogUtil.error('Method isCacheExist execute error: ' + JSON.stringify(err));
  }
};

// 下载图片至files
export const downLoadImg = function (lottieData) {
  let imgRouterFilesDir = createImageFilesDir();
  let downloadTasks = [];
  lottieData.assets.forEach((item, index) => {
    if (item.id && item.p && item.p.startsWith('http')) {
      let taskPromise = new Promise((resolve, reject) => {
        let downloadConfig = {
          action: request.agent.Action.DOWNLOAD,
          url: item.p,
          overwrite: true,
          method: 'GET',
          saveas: `./${item.id}.png`,
          mode: request.agent.Mode.FOREGROUND,
          gauge: true,
        }
        let downloadTask;
        request.agent.create(getContext(), downloadConfig, (err, task) => {
          if (err) {
            LogUtil.error(`Failed to request the upload. Code: ${err.code}, message: ${err.message}`);
            reject(JSON.stringify(err));
            return
          }
          downloadTask = task;
          downloadTask.on('completed', (progress) => {
            resolve(item);
            let srcPath = getContext().cacheDir + `/${item.id}.png`;
            let destPath = `${imgRouterFilesDir}/${item.id}.png`;
            try {
              // 移动文件
              fs.moveFileSync(srcPath, destPath);
            } catch (err) {
              LogUtil.error('moveFile err:' + JSON.stringify(err));
            }
          });
          downloadTask.on('failed', (progress) => {
            reject(progress);
          });
          downloadTask.start((err) => {
            if (err) {
              LogUtil.error(JSON.stringify(err.message));
              reject(err.message);
            }
          });
        })
      });
      downloadTasks.push(taskPromise);
    }
  });

  return Promise.all(downloadTasks)
    .then((results) => {
      LogUtil.debug('All download tasks completed success:' + JSON.stringify(results));
    })
    .catch((error) => {
      // 检查错误是否是拒绝错误
      if (error && error.message) {
        LogUtil.error('An error occurred during download:', error);
      }
      LogUtil.error('All task download fail')
      throw error; // 如果是拒绝错误，继续抛出，让调用者处理
    });
};

// 判断files目录下是否有下载的图片
export const isHaveImg = function (way) {
  try{
  let listFileOption = {
    recursion: false,
    listNum: 0,
    filter: {
      suffix: ['.png'], // 匹配文件后缀名为'.png'
      displayName: ['*'], // 匹配所有文件
      fileSizeOver: 0, // 匹配文件大小大于等于0
      lastModifiedAfter: new Date(0).getTime()    // 匹配文件最近修改时间在1970年1月1日之后
    }
  };
  let imgFiles = fs.listFileSync(way, listFileOption);
  return imgFiles.some(item => item.endsWith('.png'));
  } catch (err) {
    LogUtil.error('Method isCacheExist execute error: ' + JSON.stringify(err));
  }
};

// 获取uri后缀
export const getSuffix = function (url) {
  const lastDotIndex = url.lastIndexOf('.');
  if (lastDotIndex !== -1 && lastDotIndex < url.length - 1) {
    return url.substring(lastDotIndex);
  } else {
    return "url中没有找到合适的扩展名";
  }
};

// 处理下载有图片json中的assets
export const handleAssets = function (lottieData) {
  let updatedAssets = lottieData.assets.map((item, index) => {
    if (item.id && item.p && item.p.startsWith('http')) {
      item.p = `${item.id}.png`;
      if (!item.u) {
        item.u = 'lottie/loadImages/';
        item.e = 0;
      }
    }
    return item;
  });
  lottieData.assets = updatedAssets;
  return lottieData;
};

// 处理下载的zip资源图片路径
export const handleZipAssets = function (lottieData, zipRoute) {
  const parts = zipRoute.split('/');
  const lastPart = parts.slice(-3);
  const lastPartStr = lastPart.join('/');
  // 修改u路径
  let updatedZipAssets = lottieData.assets.map((item, index) => {
    if (item.id && item.u) {
      item.u = `${lastPartStr}/images/`;
    }
    return item;
  });
  lottieData.assets = updatedZipAssets;
  return lottieData;
};

// 创建zip和json文件目录
export const createFilesDir = function (url) {
  const parts = url.split('/');
  const secondLastSegment = parts[parts.length - 2];
  const lastSegmentWithExtension = parts[parts.length - 1];
  const lastSegment = lastSegmentWithExtension.replace(/\.(zip|json)$/i, '');
  let dirPath = getContext().filesDir + "/lottie";
  let dirPathFirst = `${dirPath}/${secondLastSegment}`;
  let dirPathSecond = `${dirPathFirst}/${lastSegment}`;
  let dirArray = [dirPath, dirPathFirst, dirPathSecond];
  try {
    dirArray.forEach(item => {
      if (!fs.accessSync(item)) {
        fs.mkdirSync(item);
      }
    });
  } catch (err) {
    LogUtil.error('Method createFilesDir mkdir err:' + JSON.stringify(err));
  }
  return {
    dataName: lastSegmentWithExtension,
    route: dirPathSecond
  };
};

// 创建images数据的文件夹
export const createImageFilesDir = function () {
  let dirImgPath = getContext().filesDir + "/lottie";
  let dirImgPathFirst = dirImgPath + "/loadImages";
  let dirImagesArray = [dirImgPath, dirImgPathFirst];
  try {
    dirImagesArray.forEach(item => {
      if (!fs.accessSync(item)) {
        fs.mkdirSync(item);
      }
    });
  } catch (err) {
    LogUtil.error('Method createImageFilesDir mkdir imgFiles err:' + JSON.stringify(err));
  }
  return dirImgPathFirst;
};