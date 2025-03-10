import { router } from '@kit.ArkUI';
import { PictureItem } from '../../viewmodel/PictureItem';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { DailyShare } from '../../server/dailyshare/DailyShareData';

/**
 * Picture component.
 */
@Component
export struct PictureView {
  photos: PictureItem = new PictureItem()

  build() {
    Column() {
      Image(this.photos.image)
        .borderRadius(CommonConstants.BORDER_RADIUS)
        .height(CommonConstants.HEIGHT_PICTURE)// ? 用WIDTH——PICTURE设置height？
        .width("100%")
        .margin({ top: '0%'})
        .objectFit(ImageFit.Cover) // 根据一个GridItem大小自动调整图片大小
        // .onClick(() => { 注释此处可以点击图片进入每日分享详情 ？疑似Banner的作用，但Banner自身设置了PLAY_PAGE
        //   router.pushUrl({ url: CommonConstants.PLAY_PAGE });
        // })

      Text(this.photos.name)
        .width(CommonConstants.PAGE_WIDTH)
        .fontSize(CommonConstants.FONT_SIZE_PHOTO_NAME)
        .fontWeight(CommonConstants.FONT_WEIGHT_NORMAL)
        .margin({ top: CommonConstants.TOP_NAME})
        .textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1) //此两处设置文字超长省略，防止遮挡


      // Text(this.photos.description)
      //   .width(CommonConstants.PAGE_WIDTH)
      //   .fontSize(CommonConstants.FONT_SIZE_DESCRIPTION)
      //   .fontWeight(CommonConstants.FONT_WEIGHT_LIGHT)
      //   .opacity($r('app.float.opacity_light'))
      //   .margin({ top: CommonConstants.TOP_DESCRIPTION, bottom: CommonConstants.BOTTOM_TEXT })
    }
    .height('115%')  //?设置115%超过100%，在text超过两行时会遮挡
  }
}