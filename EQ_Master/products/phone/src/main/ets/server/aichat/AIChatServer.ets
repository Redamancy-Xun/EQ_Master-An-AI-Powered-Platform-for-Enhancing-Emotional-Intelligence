import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import { httpRequestGet } from '../../common/utils/HttpUtil';
import Logger from '../../common/utils/Logger';
import ResponseResult from '../ResponseResult';
import { url as URL } from '@kit.ArkTS';

class AIChatServer {
  getAIChat(prompt: string): Promise<string> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${Const.GET_AI_CHAT}`;
      let params = new URL.URLParams('?prompt=' + prompt);
      url = url + '/?' + params;
      Logger.info('AIChat url:' + url);
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          console.info('AIChat success! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.info('AIChat success! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          resolve(data.result);
        } else {
          console.error('AIChat fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('AIChat fail! code:' +data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('AIChat fail!', JSON.stringify(err));
        console.error('AIChat fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      })
    })
  }
}

export default new AIChatServer();