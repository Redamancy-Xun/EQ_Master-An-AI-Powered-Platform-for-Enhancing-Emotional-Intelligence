import { preferences, ValueType } from '@kit.ArkData';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { PictureType } from '../../common/constants/PictureConstants';

@Entry
@Component
export struct DailyShareTypeShowTitleView {

  private type: string = '考验情商的热门问题';
  private count: number = 0;

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
      //   Stack() {
      //     Row() {
      //       Text($r('app.string.found'))
      //         .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_selected') :
      //         $r('app.float.title_font_size_normal'))
      //         .fontWeight(BaseCommon.FONT_WEIGHT_500)
      //         .fontColor(Color.Black)
      //         .opacity(this.isFoundSelected ? $r('app.float.title_opacity_selected') :
      //         $r('app.float.title_opacity_normal'))
      //         .onClick(()=>{
      //           this.isFoundSelected = true;
      //         })
      //
      //       Text($r('app.string.follow'))
      //         .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_normal') :
      //         $r('app.float.title_font_size_selected'))
      //         .fontWeight(BaseCommon.FONT_WEIGHT_500)
      //         .fontColor(Color.Black)
      //         .margin({
      //           left: new BreakpointType($r('app.float.title_margin_left_sm'), $r('app.float.title_margin_left_md'),
      //             $r('app.float.title_margin_left_lg')).getValue(this.currentBreakpoint)
      //         })
      //         .opacity(this.isFoundSelected ? $r('app.float.title_opacity_normal') :
      //         $r('app.float.title_opacity_selected'))
      //         .onClick(()=>{
      //           this.isFoundSelected = false;
      //         })
      //     }
      //     .width(BaseCommon.FULL_PERCENT)
      //     .height(BaseCommon.FULL_PERCENT)
      //     .justifyContent(FlexAlign.Center)
      //
      //     SearchBarView()
      //       .width(new BreakpointType($r('app.float.search_bar_view_width_sm'), $r('app.float.search_bar_view_width_md'),
      //         $r('app.float.search_bar_view_width_lg')).getValue(this.currentBreakpoint))
      //   }
      //   .alignContent(Alignment.End)
      //   .padding({
      //     left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
      //       $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
      //     right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
      //       $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
      //   })
      // }
      // .height($r('app.float.hot_title_height'))
      // .borderColor($r('app.color.hot_title_border_color'))
      // .borderWidth({
      //   bottom: new BreakpointType($r('app.float.hot_title_border_width_normal'),
      //     $r('app.float.hot_title_border_width_normal'), $r('app.float.hot_title_border_width_more')
      //   ).getValue(this.currentBreakpoint)
      // })
    }
  }
}