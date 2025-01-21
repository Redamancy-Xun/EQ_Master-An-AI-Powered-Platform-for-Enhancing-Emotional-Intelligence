import { HomeConstants } from '../../common/constants/HomeConstants';
import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants } from '../../common/constants/BreakpointConstants';
import { BaseConstants } from '../../common/constants/BaseConstants';
import { StandardIcon } from './StandardIcon';

@Component
export struct ConversationDetailTopSearch {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  // @Link currentConversationUserName: string;
  // @Consume('pageInfo') pageInfo: NavPathStack;

  build() {
    Flex({ alignItems: ItemAlign.Center }) {
      StandardIcon({ icon: $r('app.media.AI_logo') })
        .margin({ left: "1%" , bottom: "10%" })
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
      Text('AI高情商回复助手')
        .fontWeight(BaseConstants.FONT_WEIGHT_FIVE)
        .fontSize(BaseConstants.FONT_SIZE_EIGHTEEN)
        .fontWeight(FontWeight.Bolder)
        // .fontFamily(BaseConstants.FONT_FAMILY_MEDIUM)
        .fontColor($r('app.color.conversation_default_text_color'))
        .margin({ left: "2%" , bottom: "3%"})
      // StandardIcon({ icon: $r('app.media.ic_public_more') })
    }
    .width(BaseConstants.FULL_WIDTH)
    .height("90%")
    .padding({ left: $r('app.float.icon_margin_two'), right: $r('app.float.icon_margin_two'), top: "8%"})
    .borderColor($r('app.color.hot_title_border_color'))
    .borderWidth({
      bottom: ($r('app.float.hot_title_border_width_normal'))
    })
  }
}