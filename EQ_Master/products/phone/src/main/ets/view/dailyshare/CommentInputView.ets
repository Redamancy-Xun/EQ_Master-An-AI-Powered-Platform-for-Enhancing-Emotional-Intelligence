import { CommonConstants } from '../../common/constants/CommonConstants';

const TEXTAREA_KEY: string = 'textarea';
const BUTTON_KEY: string = 'button';

@Component
export struct CommentInputView {
  @State content: string = '';
  darkMode: boolean = true;

  build() {
    Row() {
      TextArea({ placeholder: $r('app.string.detail_write_comment'), text: this.content })
        .key(TEXTAREA_KEY)
        .maxLines(CommonConstants.TEXT_AREA_MAX_LINES)
        .constraintSize({
          minHeight: $r('app.float.constraint_size')
        })
        .enableKeyboardOnFocus(true)
        .maxLength(CommonConstants.TEXT_AREA_MAX_LENGTH)
        .showCounter(this.content.length === CommonConstants.TEXT_AREA_MAX_LENGTH ? true : false)
        .layoutWeight(1)
        .onChange((value: string) => {
          this.content = value;
        })
        .onAppear(() => {
          focusControl.requestFocus(TEXTAREA_KEY);
        })

      Image($r('app.media.ic_toolbar_sent'))
        .width($r('app.float.toolbar_sent_width'))
        .aspectRatio(1)
        .margin({
          left: $r('app.float.toolbar_sent_ml'),
          bottom: $r('app.float.toolbar_sent_mb')
        })
        .key(BUTTON_KEY)
        .onClick(() => {
          AppStorage.setOrCreate('isShowInput', false);
          focusControl.requestFocus(BUTTON_KEY);
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({
      left: $r('app.float.dialog_pl'),
      right: $r('app.float.dialog_pr'),
      top: $r('app.float.dialog_pt'),
      bottom: $r('app.float.dialog_pt')
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Bottom)
    .backgroundColor($r('app.color.white'))
  }
}