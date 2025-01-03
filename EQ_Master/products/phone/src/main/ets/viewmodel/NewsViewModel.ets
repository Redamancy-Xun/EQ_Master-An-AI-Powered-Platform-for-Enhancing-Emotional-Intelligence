import { CommonConstants as Const } from '../common/constants/CommonConstants';
import { NewsData } from './NewsData';
import NewsTypeModel from './NewsTypeModel';
import { httpRequestGet } from '../common/utils/HttpUtil';
import Logger from '../common/utils/Logger';
import ResponseResult from '../server/ResponseResult';

class NewsViewModel {
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
          resolve(data.result);
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