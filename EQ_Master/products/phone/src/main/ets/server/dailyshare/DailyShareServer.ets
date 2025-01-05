import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import { httpRequestGet } from '../../common/utils/HttpUtil';
import Logger from '../../common/utils/Logger';
import ResponseResult from '../ResponseResult';
import { httpRequestPost } from '../../common/utils/HttpUtil';
import PreferenceModel from '../../model/PreferenceModel';
import { DailyShare } from './DailyShareData';
import { JSON } from '@kit.ArkTS';

class DailyShareServer {

  getDailyShareTotalList(page: number, pageSize: number): Promise<Array<Array<DailyShare>>> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/dailyShare/getDailyShareTotalList?page=${page}&pageSize=${pageSize}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          // JSON.parse(data.result?.toString())
          console.info('getDailyShareTotalList success! ' + 'code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.info('getDailyShareTotalList success! result:' + data.result?.toString());
          resolve(data.result);
        } else {
          console.error('getDailyShareTotalList fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('getDailyShareTotalList fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('getDailyShareTotalList fail!', JSON.stringify(err));
        console.error('getDailyShareTotalList fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getDailyShareTypeList(type: string, page: number, pageSize: number, orderByPopularity: boolean): Promise<Array<DailyShare>> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/dailyShare/getDailyShareTypeList?type=${type}&page=${page}&pageSize=${pageSize}&orderByPopularity=${orderByPopularity}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          console.info('getDailyShareTypeList success! result:' + data.result);
          Logger.info('getDailyShareTypeList success! result:' + data.result);
          resolve(data.result);
        } else {
          console.error('getDailyShareTypeList fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('getDailyShareTypeList fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('getDailyShareTypeList fail!', JSON.stringify(err));
        console.error('getDailyShareTypeList fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getDailyShareById(dailyShareId: string): Promise<DailyShare> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/dailyShare/getDailyShareById?dailyShareId=${dailyShareId}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Const.SERVER_CODE_SUCCESS) {
          console.info('getDailyShareById success! result:' + data.result);
          Logger.info('getDailyShareById success! result:' + data.result);
          resolve(data.result);
        } else {
          console.error('getDailyShareById fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          Logger.error('getDailyShareById fail! code:' + data.code + ' message:' + data.message + ' result:' + data.result);
          reject(data);
        }
      }).catch((err: Error) => {
        Logger.error('getDailyShareById fail!', JSON.stringify(err));
        console.error('getDailyShareById fail!', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

export default new DailyShareServer();