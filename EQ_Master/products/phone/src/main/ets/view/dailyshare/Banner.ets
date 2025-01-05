import { router } from '@kit.ArkUI';
import { PictureItem } from '../../viewmodel/PictureItem';
import { PictureType } from '../../common/constants/PictureConstants';
import { initializePictures, startPlay, stopPlay } from '../../viewmodel/PictureViewModel';
import { CommonConstants } from '../../common/constants/CommonConstants';

/**
 * text style.
 *
 * @param fontSize Font size.
 * @param fontWeight Font weight.
 */
@Extend(Text)
function textStyle(fontSize: number, fontWeight: number) {
  .fontSize(fontSize)
  .fontColor($r('app.color.start_window_background'))
  .fontWeight(fontWeight)
}

/**
 * Carousel banner.
 */
@Component
export struct Banner {
  // Change the index value through a scheduled task to perform a round robin.
  @State index: number = 0;
  private imageArray: Array<PictureItem> = [];
  private swiperController: SwiperController = new SwiperController();
  private dotIndicator: DotIndicator = new DotIndicator();

  aboutToAppear() {
    this.dotIndicator.selectedColor($r('app.color.start_window_background'));
    // Data Initialization.
    this.imageArray = initializePictures(PictureType.BANNER);
    // Turn on scheduled task.
    startPlay(this.swiperController);
  }

  aboutToDisappear() {
    stopPlay();
  }

  build() {
    Swiper(this.swiperController) {
      ForEach(this.imageArray, (item: PictureItem) => {
        Stack({ alignContent: Alignment.TopStart }) {
          Image(item.image)
            .objectFit(ImageFit.Fill)
            .height(CommonConstants.FULL_HEIGHT)
            .width(CommonConstants.FULL_WIDTH)
            .borderRadius(CommonConstants.BORDER_RADIUS)
            .align(Alignment.Center)
            .onClick(() => {
              router.pushUrl({ url: CommonConstants.PLAY_PAGE });
            })

          Column() {
            Text('')
              .textStyle(CommonConstants.FONT_SIZE_DESCRIPTION, CommonConstants.FONT_WEIGHT_LIGHT)
              .opacity($r('app.float.opacity_deep'))
              .margin({ bottom: CommonConstants.BOTTOM_TEXT })
            Text(item.name)
              .textStyle(CommonConstants.FONT_SIZE_TITLE, CommonConstants.FONT_WEIGHT_BOLD)
          }
          .alignItems(HorizontalAlign.Start)
          .height(CommonConstants.HEIGHT_CAROUSEL_TITLE)
          .margin({ top: CommonConstants.TOP_ADS, left: CommonConstants.ADS_LEFT })
        }
        .height(CommonConstants.FULL_HEIGHT)
        .width(CommonConstants.FULL_WIDTH)
      }, (item: PictureItem) => JSON.stringify(item))
    }
    .width(CommonConstants.PAGE_WIDTH)
    .height(CommonConstants.HEIGHT_BANNER)
    .index(this.index)
    .indicator(this.dotIndicator)
    .duration(CommonConstants.DURATION_ADS)
  }
}