import { preferences, ValueType } from '@kit.ArkData';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { PictureType } from '../../common/constants/PictureConstants';

// @Entry //注释此处将允许预览器
@Component
export struct DailyShareTypeShowTitleView {

  @Consume type: string // 动态设置type
  public count: number = 0; // 总记录条数, 当前设置37, 在DailyShareTypeShow.ets中

  typeShow(type: string) : string {
    switch (type) {
      case PictureType.TIP:
        return '提升情商小技巧';
      case PictureType.STORY:
        return '情商趣味故事';
      case PictureType.QUESTION:
        return '考验情商的热门问题';
      default:
        return '未知类型';
    }
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.dailyShareTypeShow'))
          .width(CommonConstants.FULL_PERCENT)
          .height('20%')
          .padding({
            // left: $r('app.float.daily_share_type_show_title_padding_left'),
          })
        Text(this.typeShow(this.type))
          .fontSize('18fp')
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor(Color.White)
          .opacity(1)
          .margin({
            top: '0%',
            left: '-45%',
          })
        Text(`${this.count} 条记录`)
          .fontSize('15fp')
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor(Color.White)
          .opacity(0.8)
          .margin({
            top: '13%',
            left: '-69%',
          })
        Text(`分享，是一场无声的对话，一种心灵的共鸣~`)
          .fontSize('15fp')
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor(Color.White)
          .opacity(0.8)
          .margin({
            top: '30%',
            left: '-13%',
          })
      }
    }
  }
}