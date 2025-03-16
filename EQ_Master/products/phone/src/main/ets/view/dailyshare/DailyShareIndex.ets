import { CommonConstants } from '../../common/constants/CommonConstants'
// import { DAILY_SHARE_LIST_QUESTION,
//   DAILY_SHARE_LIST_STORY,
//   DAILY_SHARE_LIST_TIP } from '../../common/constants/DailyShareList'
import { PictureType } from '../../common/constants/PictureConstants'
import Logger from '../../common/utils/Logger'
import PromptUtil from '../../common/utils/PromptUtil'
import { DailyShare } from '../../server/dailyshare/DailyShareData'
import DailyShareServer from '../../server/dailyshare/DailyShareServer'
import ResponseResult from '../../server/ResponseResult'
import { TitleView } from '../TitleView'
import { Banner } from './Banner'
import { DailyShareShow } from './DailyShareShow'

@Entry
@Component
export struct DailyShareIndex {
  // @State intiDailyShareQuestion:Array<DailyShare> = []
  // @State intiDailyShareTip:Array<DailyShare> = []
  // @State intiDailyShareStory:Array<DailyShare> = []
  //
  // aboutToAppear(): void {
  //   this.intiDailyShareQuestion = this.getDailyShareList('question',1,4,false,this.intiDailyShareQuestion)
  //   this.intiDailyShareTip = this.getDailyShareList('tip',1,4,false,this.intiDailyShareTip)
  //   this.intiDailyShareStory = this.getDailyShareList('story',1,4,false,this.intiDailyShareStory)
  // }

  // TODO 上拉刷新、下拉加载待实现
  // TODO 懒加载待实现

  getDailyShare(page: number, pageSize: number, type: number) : Array<DailyShare> {
    let dailyShareList: Array<Array<DailyShare>> = [];
    Logger.info(CommonConstants.DAILY_SHARE_PAGE_TAG, 'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type);
    DailyShareServer.getDailyShareTotalList(page, pageSize).then((data: Array<Array<DailyShare>>) => {
      dailyShareList = data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    })
    // Logger.info(CommonConstants.DAILY_SHARE_PAGE_TAG, '!!!!!!!!!!!!!getDailyShare dailyShareList: ' + dailyShareList);

    return dailyShareList[type];
  }

  getDailyShareList(type: string, page: number, pageSize: number, orderByPopularity: boolean, dailyShareList: Array<DailyShare>): Array<DailyShare> {
    Logger.info(CommonConstants.DAILY_SHARE_TYPE_PAGE_TAG,
      'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type + ' orderByPopularity: ' +
        orderByPopularity);
    DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity).then((data: Array<DailyShare>) => {
      dailyShareList= data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    })
    return dailyShareList
  }

  build() {
    Column() {
      Row() {
        Text('       ')
          .margin({ top: '1%', bottom: '1.9%' })
        Text('每日分享')
          .margin({ top: '1%', bottom: '1.9%' })
          .fontSize('21fp')
          .fontColor(Color.Black)
          .fontWeight(560)
          .opacity(1)
        Text('详情') //可改成选项
          .fontSize('21fp')
          .fontColor(Color.Blue)
          .fontWeight(560)
          .margin({ top: '1%', bottom: '1.9%' })
      }
      .width(CommonConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceAround)
      // .borderRadius('15vp')
      .borderColor($r('app.color.hot_title_border_color'))
      .borderWidth({
        bottom: ($r('app.float.hot_title_border_width_normal'))
      })
      Scroll() {
        Column() {
          Banner()
          Blank()
            .height('2%')
          DailyShareShow({ initType: PictureType.QUESTION}) //在DailyShareShow内部根据type加载initDailyShare
          // Blank()
          //   .height('1%')
          DailyShareShow({ initType: PictureType.TIP})
          // Blank()
          //   .height('1%')
          DailyShareShow({ initType: PictureType.STORY})
          Blank()
            .height('5%')
        }
      }
      .scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
    }
    .width(CommonConstants.FULL_WIDTH)
  }
}