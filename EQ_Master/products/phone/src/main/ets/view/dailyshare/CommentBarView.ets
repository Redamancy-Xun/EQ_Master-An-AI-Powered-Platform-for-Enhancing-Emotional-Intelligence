import { CommonConstants } from '../../common/constants/CommonConstants';

const KEY_TEXTAREA: string = 'textarea_input';

@Component
export struct CommentBarView {
  // @StorageProp('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @State isMouseClick: boolean = false;
  @State content: string = '';
  isShowInput?: boolean = true;
  isDarkMode: boolean = false;
  jumpDetail: () => void = () => {
  };

  build() {
    Column() {
      Row() {
        if (!this.isMouseClick) {
          Row() {
            Text($r('app.string.detail_write_comment'))
              .fontSize($r('app.float.comment_context_fs'))
              .fontWeight(FontWeight.Normal)
              .fontColor(this.isDarkMode ? Color.White : Color.Black)
              .opacity($r('app.float.comment_context_opacity'))
          }
          .borderRadius($r('app.float.comment_context_br'))
          .backgroundColor(this.isDarkMode ? $r('app.color.dark_mode_gbc') : $r('app.color.comment_context_bgc'))
          .padding({
            left: $r('app.float.window_padding_left_sm')
          })
          .justifyContent(FlexAlign.Start)
          .height($r('app.float.comment_input_height'))
          .width(CommonConstants.COMMENT_BAR_INPUT_WIDTH)
          .margin({ left: CommonConstants.COMMENT_BAR_INPUT_ML })
          .visibility(this.isShowInput ? Visibility.Visible : Visibility.None)
          .onMouse((event: MouseEvent) => {
            if (event.button === MouseButton.Left && event.action === MouseAction.Press) {
              this.isMouseClick = true;
            }
          })
          .onClick(() => {
            if (!this.isMouseClick) {
              AppStorage.setOrCreate('isShowInput', true);
            }
          })

          Row() {
            Image(this.isDarkMode ? $r('app.media.ic_toolbar_comment_light') : $r('app.media.ic_toolbar_comment'))
              .width($r('app.float.toolbar_comment_image_width'))
              .aspectRatio(1)
              .onClick(() => {
                this.jumpDetail();
              })
            Image(this.isDarkMode ? $r('app.media.ic_toolbar_star_light') : $r('app.media.ic_toolbar_star'))
              .width($r('app.float.toolbar_comment_image_width'))
              .aspectRatio(1)
            Image(this.isDarkMode ? $r('app.media.ic_toolbar_heart_light') : $r('app.media.ic_toolbar_heart'))
              .width($r('app.float.toolbar_comment_image_width'))
              .aspectRatio(1)
            Image(this.isDarkMode ? $r('app.media.ic_toolbar_share_light') : $r('app.media.ic_toolbar_share'))
              .width($r('app.float.toolbar_comment_image_width'))
              .aspectRatio(1)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.SpaceAround)
        }
        else {
          Row() {
            TextArea({ placeholder: $r('app.string.detail_write_comment'), text: this.content })
              .fontColor(this.isDarkMode ? $r('app.color.font_color_dark') : $r('app.color.font_color_normal'))
              .backgroundColor(this.isDarkMode ? $r('app.color.comment_context_bgc_dark') :
                $r('app.color.comment_context_bgc'))
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
              .key(KEY_TEXTAREA)
              .onAppear(() => {
                focusControl.requestFocus(KEY_TEXTAREA)
              })

            Image(this.isDarkMode ? $r('app.media.ic_toolbar_send_white') : $r('app.media.ic_toolbar_sent'))
              .width($r('app.float.toolbar_sent_width'))
              .aspectRatio(1)
              .margin({
                left: $r('app.float.toolbar_sent_ml'),
                bottom: $r('app.float.toolbar_sent_mb')
              })
              .onClick(() => {
                this.isMouseClick = false;
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
          .backgroundColor(this.isDarkMode ? Color.Transparent : $r('app.color.white'))
        }
      }
      .width(CommonConstants.FULL_PERCENT)
      .height($r('app.float.toolbar_comment_height'))
      .borderWidth({ top: $r('app.float.comment_bar_border_with') })
      .borderColor(this.isDarkMode ? $r('app.color.title_board_color') : $r('app.color.comment_bar_border_color'))
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(this.getColumnHeight())
  }

  getColumnHeight(): Resource {
    // if (this.currentBreakpoint === Breakpoint.BREAKPOINT_LG) {
    //   return $r('app.float.toolbar_comment_height');
    // }
    return this.isShowInput ? $r('app.float.toolbar_comment_input_height') : $r('app.float.toolbar_comment_height');
  }
}