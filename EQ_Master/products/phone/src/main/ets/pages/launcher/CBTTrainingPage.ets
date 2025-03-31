import { router } from '@kit.ArkUI';
import Logger from '../../common/utils/Logger';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Entry
@Component
struct CBTTrainingPage {


  build() {
    Stack() {
      Column() {
        Image($r('app.media.ic_CBTTraining_background'))
          .width('90%')
          .objectFit(ImageFit.Contain)// 保持原比例缩放
          .margin({ top: 100, bottom: 65 })

        Column() {
          Column() {
            Text($r('app.string.CBTTraining_page_text1'))
              .fontSize($r('app.float.home_page_text_size'))
              .fontColor($r('app.color.Launcher_pages_title_color'))
              .opacity(1)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .padding({ top: 15 })


            Text($r('app.string.CBTTraining_page_text2'))
              .fontSize('20vp')
              .fontColor($r('app.color.Launcher_pages_text_color'))
              .opacity(1)
              .fontWeight(200)
              .padding({
                top: 20,
                left: '10%',
                right: '10%'
              })
              .lineHeight(25)
          }.height('70%').margin({top:'3%'})

          Button('下一步')
            .fontSize(18)
            .width('80%')
            .height('15%')
            .margin({top:'3%'})
            .backgroundColor('app.color.button_color')
            .onClick(() => {
              router.pushUrl({
                url: CommonConstants.EQTESTING_PAGE_URL
              }).catch((error: Error) => {
                Logger.error(CommonConstants.CBTTRAINING_PAGE_TAG, 'CBTTrainingPage pushUrl error ' + JSON.stringify(error));
              });
            })
        }
        .position({ x: 0, y: '56%' }) // 让 Column 处于底部
        .borderRadius(20)
        .backgroundColor($r('app.color.Launcher_pages_card_color'))
        .width(CommonConstants.FULL_WIDTH)
        .height('40%')

      }.width(CommonConstants.FULL_WIDTH).height(CommonConstants.FULL_HEIGHT).backgroundColor($r('app.color.background_color'))
    }
  }
}
