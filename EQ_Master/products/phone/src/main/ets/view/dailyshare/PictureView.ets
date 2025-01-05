import { router } from '@kit.ArkUI';
import { PictureItem } from '../../viewmodel/PictureItem';
import { CommonConstants } from '../../common/constants/CommonConstants';

/**
 * Picture component.
 */
@Component
export struct PictureView {
  private photos: PictureItem = new PictureItem();

  build() {
    Column() {
      Image(this.photos.image).borderRadius(CommonConstants.BORDER_RADIUS)
        .height(CommonConstants.WIDTH_PICTURE)
        .margin({ top: '0%'})
        .onClick(() => {
          router.pushUrl({ url: CommonConstants.PLAY_PAGE });
        })

      Text(this.photos.name).width(CommonConstants.PAGE_WIDTH)
        .fontSize(CommonConstants.FONT_SIZE_PHOTO_NAME)
        .fontWeight(CommonConstants.FONT_WEIGHT_NORMAL)
        .margin({ top: CommonConstants.TOP_NAME})

      // Text(this.photos.description)
      //   .width(CommonConstants.PAGE_WIDTH)
      //   .fontSize(CommonConstants.FONT_SIZE_DESCRIPTION)
      //   .fontWeight(CommonConstants.FONT_WEIGHT_LIGHT)
      //   .opacity($r('app.float.opacity_light'))
      //   .margin({ top: CommonConstants.TOP_DESCRIPTION, bottom: CommonConstants.BOTTOM_TEXT })
    }
    .height('110%')
  }
}