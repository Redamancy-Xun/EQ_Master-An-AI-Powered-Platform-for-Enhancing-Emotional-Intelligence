import { CommonConstants } from '../../common/constants/CommonConstants';

/**
 * App home page.
 */
@Entry
@Component
struct AppHomePage {
  build() {
    Stack() {
      // Image($r('app.media.ic_home_page_background'))
      //   .width(CommonConstants.FULL_WIDTH)
      //   .height(CommonConstants.FULL_HEIGHT)
      Text($r('app.string.home_page_text'))
        .fontSize($r('app.float.home_page_text_size'))
        .fontColor($r('app.color.home_page_text_color'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .height(CommonConstants.FULL_HEIGHT)
        .width(CommonConstants.FULL_WIDTH)
    }
  }
}