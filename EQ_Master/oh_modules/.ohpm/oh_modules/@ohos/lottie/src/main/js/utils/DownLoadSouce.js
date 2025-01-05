/**
 * MIT License
 *
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import {
  decompressAndReadJson,
  readJson,
  downLoadImg,
  handleAssets,
  handleZipAssets,
  isCacheExist
} from "./resourceHandling";
import request from "@ohos.request";
import fs from '@ohos.file.fs';
import {LogUtil} from '../utils/LogUtil'

const downLoadSource = (function(){
  const downloadUri = new Map();

  function downLoadNetworkSource(uri, configAnimation, errCallBack, resultDir, cacheFlag) {
    let flag = downloadUri.has(uri);
    if (flag) {
      let tasks = setInterval(() => {
        let existResult = isCacheExist(uri, resultDir.route);
        if (!existResult.isExist) {
          return;
        }
        //取消循环检测
        clearInterval(tasks);
        let repeatData = readJson(uri, resultDir.route);
        let newData = (uri.endsWith(".json") || uri.endsWith(".js")) ? repeatData : handleZipAssets(repeatData, resultDir.route);
        configAnimation(newData, false);
      }, 100);
    } else {
      // 将URI添加到Map中，表示下载已经开始
      downloadUri.set(uri, true);
      let downloadConfig = {
        action: request.agent.Action.DOWNLOAD,
        url: uri,
        overwrite: true,
        method: 'GET',
        saveas: `./${resultDir.dataName}`,
        mode: request.agent.Mode.FOREGROUND,
        gauge: true,
      };
      request.agent.create(getContext(), downloadConfig).then((requestTask) => {
        requestTask.on('completed', completeCallBack);
        requestTask.on('failed', (err) => {
          loadFail(uri, resultDir, configAnimation, errCallBack, err, cacheFlag);
        });
        requestTask.start((err) => {
          if (err) {
            errCallBack('error', err);
          }
        });
      }).catch((err) => {
        downloadUri.delete(uri);
        errCallBack('error', err);
      });
      let completeCallBack = (receivedSize, totalSize) => {
        loadSuccess(uri, resultDir, configAnimation);
      };
    }
  };

  function loadSuccess(uri, resultDir, configAnimation) {
    if (uri.endsWith(".json") || uri.endsWith(".js")) {
      let srcPath = `${getContext().cacheDir}/${resultDir.dataName}`;
      let destPath = `${resultDir.route}/${resultDir.dataName}`;
      try {
        // 移动文件
        fs.moveFileSync(srcPath, destPath);
      } catch (err) {
        LogUtil.error('moveFile err:' + JSON.stringify(err));
      }
      let lottieData = readJson(uri, resultDir.route);
      // 判断assets是否有图片 且 图片的p地址是否是以http或者https开头的
      let isExitNetworkAssets;
      if (lottieData) {
        isExitNetworkAssets = lottieData.assets.some((item) => {
          return item.p && item.p.startsWith('http');
        })
      }
      if (lottieData && lottieData.assets && lottieData.assets.length != 0 && isExitNetworkAssets) {
        downLoadImg(lottieData).then((results) => {
          // 下载成功加载网络
          let newJsonData = handleAssets(lottieData);
          configAnimation(newJsonData, true);
        })
          .catch((err) => {
            // 下载失败加载缓存
            LogUtil.error('Download error:' + JSON.stringify(err));
            errCallBack('error', err);
            let filesJsonData = handleAssets(lottieData);
            configAnimation(filesJsonData, false);
          });
      } else {
        // 读取成功从Map中移除条目
        // uri方式无图片的json网络资源
        downloadUri.delete(uri);
        configAnimation(lottieData, true);
      }
    } else if (uri.endsWith(".zip")) {
      decompressAndReadJson(uri, `${getContext().cacheDir}`, resultDir.route).then((result) => {
        // 解压成功，从Map中移除条目
        downloadUri.delete(uri);
        configAnimation(result, true);
      }).catch((errData) => {
        // 解压失败，从Map中移除条目
        downloadUri.delete(uri);
        errCallBack('error', errData);
      });
    }
  };

  function loadFail(uri, resultDir, configAnimation, errCallBack, err, cacheFlag) {
    // 处理网络异常加载缓存
    let existResult = isCacheExist(uri, resultDir.route);
    if (existResult.isExist && cacheFlag) {
      downloadUri.delete(uri);
      let cacheData = readJson(uri, resultDir.route);
      let newData = (uri.endsWith(".json") || uri.endsWith(".js")) ? cacheData : handleZipAssets(cacheData, resultDir.route);
      configAnimation(newData, false);
    } else {
      // 缓存无资源，给用户返回加载异常
      downloadUri.delete(uri);
      err.reason = 'download fail';
      errCallBack('error', err);
    }
  };

  return {
    downLoadNetworkSource: (uri, configAnimation, errCallBack, resultDir, cacheFlag) => {
      downLoadNetworkSource(uri, configAnimation, errCallBack, resultDir, cacheFlag);
    }
  };
}());

export default downLoadSource;