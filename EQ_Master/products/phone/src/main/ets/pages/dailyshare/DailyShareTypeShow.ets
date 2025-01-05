import { CommonConstants } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';
import PromptUtil from '../../common/utils/PromptUtil';
import PreferenceModel from '../../model/PreferenceModel';
import { DailyShare } from '../../server/dailyshare/DailyShareData';
import DailyShareServer from '../../server/dailyshare/DailyShareServer';
import ResponseResult from '../../server/ResponseResult';
import { DailyShareTypeShowContentView } from '../../view/dailyshare/DailyShareTypeShowContentView';
import { preferences } from '@kit.ArkData';
import { DailyShareTypeShowTitleView } from '../../view/dailyshare/DailyShareTypeShowTitleView';
import { DailyShareItem, DAILY_SHARE_LIST_QUESTION,
  DAILY_SHARE_LIST_STORY,
  DAILY_SHARE_LIST_TIP } from '../../common/constants/DailyShareList';

@Entry
@Component
struct DailyShareTypeShow {

  // TODO 后期实现懒加载，非瀑布式
  // TODO 论坛完善，巨多：点赞、评论、收藏、分享、浏览等；显示等问题

  private type = PreferenceModel.getPreference('dailyShareType', '').toString();
  private dailyShareList: Array<DailyShare> = [];

  getDailyShare(type: string, page: number, pageSize: number, orderByPopularity: boolean) : Array<DailyShare> {
    Logger.info(CommonConstants.DAILY_SHARE_TYPE_PAGE_TAG,
      'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type + ' orderByPopularity: ' +
        orderByPopularity);
    DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity).then((data: Array<DailyShare>) => {
      this.dailyShareList = data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    })

    return this.dailyShareList;
  }

  build() {
    Column() {
      Column() {
        DailyShareTypeShowTitleView({type: this.type, count: 37})
        DailyShareTypeShowContentView({dailyShareListByPopularity: this.type == 'question' ?
          DAILY_SHARE_LIST_QUESTION.slice(4, 9) : this.type == 'tip' ?
          DAILY_SHARE_LIST_TIP.slice(4, 9) : DAILY_SHARE_LIST_STORY.slice(4, 9),
          dailyShareListByTime: this.type == 'question' ?
          DAILY_SHARE_LIST_QUESTION.slice(9, ) : this.type == 'tip' ?
            DAILY_SHARE_LIST_TIP.slice(9, ) : DAILY_SHARE_LIST_STORY.slice(9, )})
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .padding({
      // top: deviceInfo.deviceType === BaseCommon.DEVICE_2IN1 ? $r('app.float.zero') : $r('app.float.device_padding_top')
    })
    .backgroundColor($r('app.color.white'))
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Start)
  }
}