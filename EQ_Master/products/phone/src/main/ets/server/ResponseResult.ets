/**
 * Data returned by the network request.
 */
import { DailyShare } from './dailyshare/DailyShareData';
import{ UserInfo } from '../server/user/UserData'

export default class ResponseResult {
  /**
   * Code returned by the network request.
   */
  code: number | null;

  /**
   * Message returned by the network request.
   */
  message: string | Resource | null;

  /**
   * Data returned by the network request.
   */
  result: DailyShare | Array<Array<DailyShare>> | Array<DailyShare> |UserInfo| string | number | boolean | null;

  // resultDailyShare: string;

  constructor() {
    this.code = null;
    this.message = null;
    this.result = null;
    // this.resultDailyShare = '';
  }
}