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

@Entry
@Component
struct DailyShareTypeShow {
  //只在此处调用了后端数据

  // TODO 后期实现懒加载，非瀑布式
  // TODO 论坛完善，巨多：点赞、评论、收藏、分享、浏览等；显示等问题

  @State type:string = PreferenceModel.getPreference('dailyShareType', '').toString()
  @Provide dailyShareListByPopularity: Array<DailyShare> = [] // 改变量名, 因为provide和consume需要通过变量名链接
  @Provide dailyShareListByTime: Array<DailyShare> = []


  getDailyShareListByPopularity(type: string, page: number, pageSize: number, orderByPopularity: boolean){ // 函数本身就有赋值, 故删除返回值,
    Logger.info(CommonConstants.DAILY_SHARE_TYPE_PAGE_TAG,
      'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type + ' orderByPopularity: ' +
        orderByPopularity);
    DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity).then((data: Array<DailyShare>) => {
      this.dailyShareListByPopularity= data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    })
  }

  async getDailyShareListByTime(type: string, page: number, pageSize: number, orderByPopularity: boolean){ // 函数本身就有赋值, 故删除返回值,
    Logger.info(CommonConstants.DAILY_SHARE_TYPE_PAGE_TAG,
      'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type + ' orderByPopularity: ' +
        orderByPopularity);
    this.dailyShareListByTime = await DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity)

  //   DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity)
  //   .then((data: Array<DailyShare>) => {
  //     this.dailyShareListByTime= data;
  //   })
  //   .catch((err: Resource | ResponseResult) => {
  //     if (err instanceof ResponseResult) {
  //       if (err.message !== null) {
  //         PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
  //       }
  //     } else {
  //       PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
  //     }
  //   })
  }

  aboutToAppear(): void { // 处理函数
    this.getDailyShareListByPopularity(this.type, 1, 5, false);  // 根据热度从高到低选取前5个DailyShare
    this.getDailyShareListByTime(this.type, 1, 100, false)
  }

  build() {
    Column() {
      Column() {
        //TODO count改成后端的记录总数, 目前没有后端接口能提供
        DailyShareTypeShowTitleView({count:37, type:this.type})
        DailyShareTypeShowContentView(
          // {
          // dailyShareListByPopularity: this.type == 'question' ?
          // DAILY_SHARE_LIST_QUESTION.slice(4, 9) : this.type == 'tip' ?
          // DAILY_SHARE_LIST_TIP.slice(4, 9) : DAILY_SHARE_LIST_STORY.slice(4, 9),
          // dailyShareListByTime: this.type == 'question' ?
          // DAILY_SHARE_LIST_QUESTION.slice(9, ) : this.type == 'tip' ?
          // DAILY_SHARE_LIST_TIP.slice(9, ) : DAILY_SHARE_LIST_STORY.slice(9, )
          // }
        )
      }// 先根据type选择5条一个同type的DailyShare(根据热度排列), 再加载该type下剩余的所有DailyShare(根据时间先后排列)
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .backgroundColor($r('app.color.white'))
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Start)
  }
}