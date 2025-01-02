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
      let params: string = "telephone=" + telephone + "&password=" + password;
      httpRequestPost(url, params).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          if (data.result !== null) {
            let userInfo: UserInfo = JSON.parse(data.result.toString());
            if (userInfo.sessionId !== null) {
              PreferenceModel.putPreference(Const.PREFERENCES_KEY_SESSION, userInfo.sessionId);
            }
          }
          console.info('UserLogin success! userinfo:' + data.result);
          Logger.info('UserLogin success! userinfo:' + data.result);
          resolve(data.result);
        } else {
          console.error('UserLogin fail! code:' + data.code + ' message:' + data.message);
          Logger.error('UserLogin fail! code:' + data.code + ' message:' + data.message);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('UserLogin fail!', JSON.stringify(err));
        console.error('UserLogin fail!', JSON.stringify(err));
        reject(err);
        }
      )
    })
  }

  /**
   * Get news type list from server.
   *
   * @return NewsTypeBean[] newsTypeList
   */
  getNewsTypeList(): Promise<NewsTypeModel[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${Const.GET_NEWS_TYPE}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          resolve(data.result);
        } else {
          reject(Const.TabBars_DEFAULT_NEWS_TYPES);
        }
      }).catch(() => {
        reject(Const.TabBars_DEFAULT_NEWS_TYPES);
      });
    });
  }

  /**
   * Get default news type list.
   *
   * @return NewsTypeBean[] newsTypeList
   */
  getDefaultTypeList(): NewsTypeModel[] {
    return Const.TabBars_DEFAULT_NEWS_TYPES;
  }

  /**
   * Get news type list from server.
   *
   * @return NewsData[] newsDataList
   */
  getNewsList(currentPage: number, pageSize: number, path: string): Promise<NewsData[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${path}`;
      url += '?currentPage=' + currentPage + '&pageSize=' + pageSize;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getNewsList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getNewsList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let newsViewModel = new NewsViewModel();

export default newsViewModel as NewsViewModel;