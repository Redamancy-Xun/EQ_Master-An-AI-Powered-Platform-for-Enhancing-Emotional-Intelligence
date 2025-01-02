import { router } from '@kit.ArkUI';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { GlobalContext } from '../../common/utils/GlobalContext';

/**
 * The privacy agreement page displays the agreement content.
 */
@Entry
@Component
struct PrivacyPage {
  build() {
    Scroll() {
      Column() {
        Text($r('app.string.privacy_text_title'))
          .fontSize($r('app.float.privacy_text_title_size'))
          .textAlign(TextAlign.Center)
          .margin({
            top: $r('app.float.privacy_text_margin_top'),
            bottom: $r('app.float.privacy_text_margin_bottom')
          })
        Text($r('app.string.privacy_text_content'))
          .fontSize($r('app.float.dialog_common_text_size'))
          .margin({
            left: $r('app.float.privacy_text_content_left'),
            right: $r('app.float.privacy_text_content_right')
          })
        Text($r('app.string.privacy_back'))
          .fontColor($r('app.color.privacy_back_text'))
          .fontSize($r('app.float.privacy_back_text_size'))
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            // globalThis.isJumpPrivacy = false;
            GlobalContext.getContext().setObject('isJumpPrivacy', false);
            router.back();
          })
          .margin({ top: $r('app.float.privacy_bottom_text_margin') })
      }
      .justifyContent(FlexAlign.Center)
      // .height(CommonConstants.FULL_HEIGHT)
    }
  }

  onBackPress() {
    // globalThis.isJumpPrivacy = false;
    GlobalContext.getContext().setObject('isJumpPrivacy', false);
  }
}