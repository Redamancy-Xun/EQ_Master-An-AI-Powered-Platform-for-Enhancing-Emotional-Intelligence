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

@Entry
@Component
export struct Banner {
  @State index: number = 0;
  @State selectedOption: string = 'eq' // 默认选中情商智力
  private imageArray: Array<PictureItem> = [];
  private image:PictureItem=new PictureItem()
  private swiperController: SwiperController = new SwiperController();
  private dotIndicator: DotIndicator = new DotIndicator();

  aboutToAppear() {
    // this.dotIndicator.selectedColor($r('app.color.start_window_background'));
    this.imageArray = initializePictures(PictureType.BANNER);
    this.image = this.imageArray[0];// 临时, 背景图只有一张, 不滚动
    // startPlay(this.swiperController);
  }

  // aboutToDisappear() {
  //   stopPlay();
  // }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
        Image(this.image.image)
          .objectFit(ImageFit.Fill)
          .height(CommonConstants.FULL_HEIGHT)
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius(CommonConstants.BORDER_RADIUS)
          .align(Alignment.Center)
          // .onClick(() => {
          //   router.pushUrl({ url: CommonConstants.PLAY_PAGE });
          // })

        Column() {
          Column(){
            Text('# 每日分享 #')
              .textStyle(CommonConstants.FONT_SIZE_TITLE, CommonConstants.FONT_WEIGHT_BOLD)
              .margin({ bottom: CommonConstants.BOTTOM_TEXT })
            Text('VLOG')
              .textStyle(CommonConstants.FONT_SIZE_TITLE, CommonConstants.FONT_WEIGHT_BOLD)
              .textAlign(TextAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          Row(){
            Button('情商智力', { type: ButtonType.Capsule, stateEffect: false })
              .backgroundColor(this.selectedOption === 'eq' ? 0x317aff : 0x8db6ff) // 选中时深色，未选中时浅色
              .animation({ duration: 200, curve: Curve.EaseInOut })
              .width('48%')
              .margin(2)
              .onClick(()=>{
                this.selectedOption = 'eq'
                console.info('EQ selected')
              })
            Button('社交技能', { type: ButtonType.Capsule, stateEffect: false })
              .backgroundColor(this.selectedOption === 'social' ? 0x317aff : 0x8db6ff)
              .animation({ duration: 200, curve: Curve.EaseInOut })
              .width('48%')
              .margin(2)
              .onClick(()=>{
                this.selectedOption = 'social'
                console.info('Social selected')
              })
          }
          // .margin({top:40})
          .width('80%')
          .alignSelf(ItemAlign.Center)
          .justifyContent(FlexAlign.SpaceAround)
          .backgroundColor(0xffffff)
          .borderRadius(20)
        }
        .linearGradient({
          angle:20,
          // 0点方向顺时针旋转为正向角度，线性渐变起始角度的默认值为180°
          colors: [
            [0xFFb5deff, 0.0],
            [0xFFc6f6ff, 1.0]
          ]
        })
        .borderRadius(20)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
        .height('100%')
        .width('100%')
        .margin({ top: CommonConstants.TOP_ADS, left: CommonConstants.ADS_LEFT })
      }
      .width(CommonConstants.PAGE_WIDTH)
      .height(CommonConstants.HEIGHT_BANNER)
  //   Swiper(this.swiperController) {
  //     ForEach(this.imageArray, (item: PictureItem) => {
  //       Stack({ alignContent: Alignment.TopStart }) {
  //         Image(item.image)
  //           .objectFit(ImageFit.Fill)
  //           .height(CommonConstants.FULL_HEIGHT)
  //           .width(CommonConstants.FULL_WIDTH)
  //           .borderRadius(CommonConstants.BORDER_RADIUS)
  //           .align(Alignment.Center)
  //           .onClick(() => {
  //             router.pushUrl({ url: CommonConstants.PLAY_PAGE });
  //           })
  //
  //         Column() {
  //           Text('')
  //             .textStyle(CommonConstants.FONT_SIZE_DESCRIPTION, CommonConstants.FONT_WEIGHT_LIGHT)
  //             .opacity($r('app.float.opacity_deep'))
  //             .margin({ bottom: CommonConstants.BOTTOM_TEXT })
  //           Text(item.name)
  //             .textStyle(CommonConstants.FONT_SIZE_TITLE, CommonConstants.FONT_WEIGHT_BOLD)
  //         }
  //         .alignItems(HorizontalAlign.Start)
  //         .height(CommonConstants.HEIGHT_CAROUSEL_TITLE)
  //         .margin({ top: CommonConstants.TOP_ADS, left: CommonConstants.ADS_LEFT })
  //       }
  //       .height(CommonConstants.FULL_HEIGHT)
  //       .width(CommonConstants.FULL_WIDTH)
  //     }, (item: PictureItem) => JSON.stringify(item))
  //   }
  //   .width(CommonConstants.PAGE_WIDTH)
  //   .height(CommonConstants.HEIGHT_BANNER)
  //   .index(this.index)
  //   .indicator(this.dotIndicator)
  //   .duration(CommonConstants.DURATION_ADS)
  }
}