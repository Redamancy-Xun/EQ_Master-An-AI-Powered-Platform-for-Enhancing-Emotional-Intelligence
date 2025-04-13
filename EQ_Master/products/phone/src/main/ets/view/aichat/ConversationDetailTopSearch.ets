import { HomeConstants } from '../../common/constants/HomeConstants';
import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants } from '../../common/constants/BreakpointConstants';
import { BaseConstants } from '../../common/constants/BaseConstants';
import { StandardIcon } from './StandardIcon';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Component
export struct ConversationDetailTopSearch {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  // @Link currentConversationUserName: string;
  // @Consume('pageInfo') pageInfo: NavPathStack;

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center })  {
      Column() {
        StandardIcon({ icon: $r('app.media.AI_logo') })
          .margin({ top: '1%', bottom: '1.9%' })
        //   .onClick(() => {
        //     if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
        //       this.pageInfo.clear();
        //     } else if (this.pageInfo.size() === 1) {
        //       this.pageInfo.clear();
        //       this.pageInfo.pushPath({ name: 'ConversationDetailNone' });
        //     } else {
        //       this.pageInfo.clear();
        //       this.pageInfo.pushPath({ name: 'ConversationDetailNone' });
        //     }
        //   })
        Text('AI助手')
          .fontWeight(BaseConstants.FONT_WEIGHT_FIVE)
          .fontSize(BaseConstants.FONT_SIZE_EIGHTEEN)
          .fontWeight(FontWeight.Bolder)// .fontFamily(BaseConstants.FONT_FAMILY_MEDIUM)
          .fontColor($r('app.color.conversation_default_text_color'))
          .margin({ left: "2%", bottom: "3%" })
        // StandardIcon({ icon: $r('app.media.ic_public_more') })
      }
      .alignItems(HorizontalAlign.Center)
      .flexGrow(1)
      .width('80%')
      .height("100%")
      .padding({ left: $r('app.float.icon_margin_two'), right: $r('app.float.icon_margin_two'), top: "2%" })
      .borderColor($r('app.color.hot_title_border_color'))
      .borderWidth({
        bottom: ($r('app.float.hot_title_border_width_normal'))
      })
      Text('详情')
        .layoutWeight(CommonConstants.LAYOUT_WEIGHT)
        .textAlign(TextAlign.End)
        .fontSize(CommonConstants.FONT_SIZE_PHOTO_NAME)
        .fontWeight(CommonConstants.FONT_WEIGHT_LIGHT)
        .lineHeight(CommonConstants.LINE_HEIGHT_MORE)
        .opacity($r('app.float.opacity_light'))
        .fontColor($r('app.color.start_window_background'))
        .onClick(() => {
          console.log("详情");
        })
    }
  }
}