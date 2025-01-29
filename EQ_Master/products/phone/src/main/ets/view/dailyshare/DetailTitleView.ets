import { deviceInfo } from '@kit.BasicServicesKit';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { router } from '@kit.ArkUI';

@Entry
@Component
export struct DetailTitleView {
  // @StorageLink('currentBreakpoint') @Watch('checkFoldable') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  // @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  // @State foldable: boolean = this.currentBreakpoint === Breakpoint.BREAKPOINT_MD;
  @State foldable: boolean = false;
  isShowedButton?: boolean = true;

  checkFoldable() {
    // this.foldable = this.currentBreakpoint === Breakpoint.BREAKPOINT_MD;
    this.foldable = false;
  }

  build() {
    Column() {
      // Blank()
      //   // .height(deviceInfo.deviceType !== CommonConstants.DEVICE_2IN1 ? $r("app.float.title_blank_height") :
      //   //   $r('app.float.blank_top_height'))
      //   .height($r("app.float.title_blank_height"))
      //   .width(CommonConstants.FULL_PERCENT)

      Row() {
        Stack() {
          Row() {
            Text($r('app.string.card_detail_title'))
              .height(CommonConstants.FULL_PERCENT)
              .fontSize($r('app.float.card_detail_fs'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .width(CommonConstants.FULL_PERCENT)
          .justifyContent(FlexAlign.Center)

          Row() {
            Image($r('app.media.ic_public_back'))
              .margin({
                // left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
                //   $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
                left: $r('app.float.window_padding_left_sm')
              })
              .width($r('app.float.card_detail_back_width'))
              .aspectRatio(1)
              .onClick(() => {
                // this.pageInfos.pop(); // pageInfos是navigation使用的元素
                router.back(); // router的栈顶弹出
                AppStorage.setOrCreate('isDetailPage', false);
              })

            Image(this.isFoldHorizontal ? $r('app.media.ic_fold_horizontal') : $r('app.media.ic_fold_vertical'))
              .margin({ right: $r("app.float.card_detail_fold_mr") })
              .width($r('app.float.card_detail_more_width'))
              .aspectRatio(1)
              .visibility(this.isShowedButton && this.foldable ? Visibility.Visible : Visibility.Hidden)
              .onClick(() => {
                this.isFoldHorizontal = !this.isFoldHorizontal;
              })
          }
          .width(CommonConstants.FULL_PERCENT)
          .height(CommonConstants.FULL_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .height(CommonConstants.FULL_PERCENT)
      }
      .height($r('app.float.detail_title_height'))
    }
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor($r('app.color.card_detail_title_bgc'))
  }
}