import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import { httpRequestGet } from '../../common/utils/HttpUtil';
import Logger from '../../common/utils/Logger';
import ResponseResult from '../ResponseResult';
import { httpRequestPost } from '../../common/utils/HttpUtil';
import PreferenceModel from '../../model/PreferenceModel';
import { UserInfo } from './UserData';

class UserServer {
  postUserLogin(telephone: string, password: string): Promise<UserInfo> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${Const.POST_USER_LOGIN}`;
      let params: string = "?telephone=" + telephone + "&password=" + password;
      url = url + params;
      httpRequestPost(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          // if (data.result !== null) {
          //   let userInfo: UserInfo = JSON.parse(data.result.toString());
          //   if (userInfo.sessionId !== null) {
          //     PreferenceModel.putPreference(Const.PREFERENCES_KEY_SESSION, userInfo.sessionId);
          //   }
          // }
          console.info('UserLogin success! userinfo:' + data.result);
          Logger.info('UserLogin success! userinfo:' + data.result);
          resolve(data.result);
        } else {
          console.error('UserLogin fail! telephone:' + telephone + ' password:' + password + ' code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('UserLogin fail! telephone:' + telephone + ' password:' + password + ' code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('UserLogin fail!', JSON.stringify(err));
        console.error('UserLogin fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      })
    })
  }

  postUserSignup(username: string, telephone: string, password: string): Promise<UserInfo> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${Const.POST_USER_SIGNUP}`;
      let params: string = "?username=" + username + "&telephone=" + telephone + "&password=" + password;
      url = url + params;
      httpRequestPost(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          // if (data.result !== null) {
          //   let userInfo: UserInfo = JSON.parse(data.result.toString());
          //   if (userInfo.sessionId !== null) {
          //     PreferenceModel.putPreference(Const.PREFERENCES_KEY_SESSION, userInfo.sessionId);
          //   }
          // }
          console.info('UserSignup success! userinfo:' + data.result);
          Logger.info('UserSignup success! userinfo:' + data.result);
          resolve(data.result);
        } else {
          console.error('UserSignup fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('UserSignup fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('UserSignup fail!', JSON.stringify(err));
        console.error('UserSignup fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      })
    })
  }

  getCheckLogin(): Promise<number> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${Const.GET_USER_CHECK_LOGIN}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          console.info('CheckLogin success! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.info('CheckLogin success! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          resolve(data.code);
        } else {
          console.error('CheckLogin fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('CheckLogin fail! code:' +data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('CheckLogin fail!', JSON.stringify(err));
        console.error('CheckLogin fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      })
    })
  }
}

export default new UserServer();