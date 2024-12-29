import { router } from '@kit.ArkUI';
import Logger from '../common/utils/Logger';
import CommonConstants from '../common/constants/CommonConstants';

@Entry
@Component
struct FirstPage {


  build() {
    Stack() {
      Image($r('app.media.ic_third_page_background'))
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
      Column(){

      }
      .backgroundColor($r('app.color.text_backgroud_color'))
      .opacity(0.3)
      .width('100%')
      .height('25%')
      .margin({top:700})
      .margin({top:300})

      Column() {
        Text($r('app.string.third_page_text1'))
          .fontSize($r('app.float.home_page_text_size'))
          .fontColor($r('app.color.third_page_text_color'))
          .opacity(1)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .padding({top:15})


        // .height(CommonConstants.FULL_HEIGHT)
        // .width(CommonConstants.FULL_WIDTH)
        Text($r('app.string.third_page_text2'))
          .fontSize(20)
          .fontColor($r('app.color.third_page_text_color'))
          .opacity(1)
          .fontWeight(200)
          .textAlign(TextAlign.Center)
          .padding({top:20,
            left:5,
            right:5})
          .lineHeight(25)
        // .height(CommonConstants.FULL_HEIGHT)
        // .width(CommonConstants.FULL_WIDTH)

      }
      .width('100%')
      .height('25%')
      .margin({top:300})


      Button('一起成为情商高手！')
        .fontSize(18)
        .width(300)
        .height(55)
        .backgroundColor(Color.Blue)
        .margin({ top: 600})
        .onClick(() => {
          router.pushUrl({
            url: CommonConstants.APP_HOME_PAGE_URL
          }).catch((error: Error) => {
            Logger.error(CommonConstants.THIRD_PAGE_TAG, 'ThirdPage pushUrl error ' + JSON.stringify(error));
          });
        })

    }
  }
}