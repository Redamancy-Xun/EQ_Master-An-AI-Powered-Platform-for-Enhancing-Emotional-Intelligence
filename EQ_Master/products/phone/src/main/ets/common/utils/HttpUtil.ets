import { http } from '@kit.NetworkKit';
import PreferenceModel from '../../model/PreferenceModel';
import ResponseResult from '../../server/ResponseResult';
import { CommonConstants as Const, ContentType } from '../constants/CommonConstants';
import { preferences } from '@kit.ArkData';
import Logger from './Logger';


/**
 * Initiates an HTTP GET request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let session: preferences.ValueType = PreferenceModel.getPreference("session", '');
  let responseResult: Promise<http.HttpResponse>;
  if (session == '') {
    responseResult = httpRequest.request(url, {
      method: http.RequestMethod.GET,
      readTimeout: Const.HTTP_READ_TIMEOUT,
      header: {
        'Content-Type': ContentType.JSON
      },
      connectTimeout: Const.HTTP_READ_TIMEOUT,
      extraData: {}
    });
  } else {
    responseResult = httpRequest.request(url, {
      method: http.RequestMethod.GET,
      readTimeout: Const.HTTP_READ_TIMEOUT,
      header: {
        'Content-Type': ContentType.JSON,
        'session': PreferenceModel.getPreference("session", '')
      },
      connectTimeout: Const.HTTP_READ_TIMEOUT,
      extraData: {}
    });
  }
  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === Const.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      // if (resultJson.code === Const.SERVER_CODE_SUCCESS) {
      //   serverData.result = resultJson.result;
      // }
      serverData.code = resultJson.code;
      serverData.message = resultJson.message;
      serverData.result = resultJson.result;

      console.info('Result:' + JSON.stringify(value.result));
      console.info('code:' + JSON.stringify(value.responseCode));
      console.info('header:' + JSON.stringify(value.header));
      console.info('cookies:' + JSON.stringify(value.cookies));
      Logger.info('httpRequestGet success:', JSON.stringify(value));

      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    } else {
      serverData.message = `${$r('app.string.http_error_message')}&${value.responseCode}`;

      console.error('Result:' + JSON.stringify(value.result));
      console.error('code:' + JSON.stringify(value.responseCode));
      console.error('header:' + JSON.stringify(value.header));
      console.error('cookies:' + JSON.stringify(value.cookies));
      Logger.error('httpRequestGet failed:', JSON.stringify(value));

      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    }
    return serverData;
  }).catch((err: Error) => {
    serverData.message = $r('app.string.http_error_message');

    Logger.error('network failed', JSON.stringify(err));
    console.error('network failed!', JSON.stringify(err));

    // 当该请求使用完毕时，调用destroy方法主动销毁
    httpRequest.destroy();
    return serverData;
  })
}


/**
 * Initiates an HTTP POST request to a given URL.
 *
 * @param url URL for initiating an HTTP POST request.
 * @param data Data to be sent in the POST request body.
 */
export function httpRequestPost(url: string, data: Object): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let session: preferences.ValueType = PreferenceModel.getPreference("session", '');
  let responseResult: Promise<http.HttpResponse>;

  if (session == '') {
    responseResult = httpRequest.request(url, {
      method: http.RequestMethod.POST,
      readTimeout: Const.HTTP_READ_TIMEOUT,
      header: {
        'Content-Type': ContentType.JSON
      },
      connectTimeout: Const.HTTP_READ_TIMEOUT,
      extraData: data
    });
  } else {
    responseResult = httpRequest.request(url, {
      method: http.RequestMethod.POST,
      readTimeout: Const.HTTP_READ_TIMEOUT,
      header: {
        'Content-Type': ContentType.JSON,
        'session': session
      },
      connectTimeout: Const.HTTP_READ_TIMEOUT,
      extraData: data
    });
  }

  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === Const.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      serverData.code = resultJson.code;
      serverData.message = resultJson.message;
      serverData.result = resultJson.result;

      console.info('Result:' + JSON.stringify(value.result));
      console.info('code:' + JSON.stringify(value.responseCode));
      console.info('header:' + JSON.stringify(value.header));
      console.info('cookies:' + JSON.stringify(value.cookies));
      Logger.info('httpRequestGet success:', JSON.stringify(value));

      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    } else {
      serverData.message = `${$r('app.string.http_error_message')}&${value.responseCode}`;

      console.error('Result:' + JSON.stringify(value.result));
      console.error('code:' + JSON.stringify(value.responseCode));
      console.error('header:' + JSON.stringify(value.header));
      console.error('cookies:' + JSON.stringify(value.cookies));
      Logger.error('httpRequestGet failed:', JSON.stringify(value));

      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    }
    return serverData;
  }).catch((err: Error) => {
    serverData.message = $r('app.string.http_error_message');

    Logger.error('network failed', JSON.stringify(err));
    console.error('network failed!', JSON.stringify(err));

    // 当该请求使用完毕时，调用destroy方法主动销毁
    httpRequest.destroy();
    return serverData;
  });
}