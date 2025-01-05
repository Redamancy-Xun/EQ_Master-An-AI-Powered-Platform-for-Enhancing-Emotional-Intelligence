import { CommonConstants } from '../../common/constants/CommonConstants';
import { CardItemInterface } from '../../model/CardListModel';
import { CardItem } from '../../viewmodel/CardViewModel';

interface ImageInfo {
  width: number;
  height: number;
  componentWidth: number;
  componentHeight: number;
  loadingStatus: number;
  contentWidth: number;
  contentHeight: number;
  contentOffsetX: number;
  contentOffsetY: number;
}

@Component
export struct MircoBlogView {
  // @StorageProp('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @StorageLink('isDetailPage') isDetailPage: boolean = false;
  @StorageLink('isPictureDetail') isPictureDetail: boolean = false;
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State index: number = 0;
  @State cardItem: CardItem = new CardItem();
  @State showPicture: boolean = true;
  @State imageWidth: string = CommonConstants.FULL_PERCENT;
  @State contentFontSize: number = CommonConstants.CONTENT_FONT_SIZE;
  @State contentFontHeight: number = CommonConstants.CONTENT_FONT_HEIGHT;
  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  @State pictureMarginTop: number = CommonConstants.PICTURE_MARGIN_TOP;
  isDarkMode: boolean = false;
  jumpDetail: () => void = () => {
  };

  // TODO 可以往论坛的方向再发展发展，官方账号、私人账号、关注、自由发送‘每日分享’但是以官方号为主

  jump(index: number) {
    AppStorage.setOrCreate('selectCardIndex', this.index);
    if (this.isDetailPage) {
      this.pageInfos.replacePath({ name: 'pictureDetail', param: index });
    } else {
      this.pageInfos.pushPath({ name: 'pictureDetail', param: index });
    }
  }

  build() {
    Column() {
      if (this.cardItem !== undefined) {
        Row() {
          Row() {
            Image(this.cardItem.icon)
              .width($r('app.float.blog_icon_width'))
              .aspectRatio(1)
              .borderRadius($r('app.float.blog_icon_br'))

            Column() {
              Text(this.cardItem.name)
                .fontSize($r('app.float.blog_name_fs'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .height($r('app.float.blog_name_height'))
                .fontColor(this.isDarkMode ? $r('app.color.card_item_name_fc_dark') : Color.Black)

              Text(this.cardItem.authorType)
                .fontWeight(FontWeight.Normal)
                .fontSize($r('app.float.author_type_fs'))
                .fontColor(this.isDarkMode ? $r('app.color.author_type_fc_dark') : $r('app.color.author_type_color'))
                .height($r('app.float.author_type_height'))
            }
            .margin({ left: $r('app.float.blog_title_ml') })
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
          }
          .justifyContent(FlexAlign.Start)

          Row() {
            Image(this.isDarkMode ? $r('app.media.ic_public_add_white') : $r('app.media.ic_public_add'))
              .width($r('app.float.blog_add_width'))
              .aspectRatio(1)

            Text($r('app.string.blog_follow'))
              .fontSize($r('app.float.follow_font_size'))
              .margin({ left: $r('app.float.follow_margin_left') })
              .fontColor(this.isDarkMode ? Color.White : $r('app.color.follow_font_color'))
          }
          .borderRadius($r('app.float.blog_title_follow_br'))
          .backgroundColor(this.isDarkMode ? $r('app.color.dark_mode_gbc') : $r('app.color.replay_bgc'))
          .padding({
            left: $r('app.float.blog_title_padding_left'),
            right: $r('app.float.blog_title_padding_left')
          })
          .width($r('app.float.blog_title_follow_width'))
          .height($r('app.float.blog_title_follow_height'))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(CommonConstants.FULL_PERCENT)
        .padding({
          top: $r('app.float.card_title_padding'),
          bottom: $r('app.float.card_title_padding')
        })

        Row() {
          Text(this.cardItem.content)
            .fontSize(`${this.contentFontSize}${CommonConstants.SUFFIX_FP}`)
            .lineHeight(`${this.contentFontHeight}${CommonConstants.SUFFIX_VP}`)
            .width(CommonConstants.FULL_PERCENT)
            .onClick(() => {
              this.jumpDetail();
            })
            .fontColor(this.isDarkMode ? $r('app.color.card_item_content_fc_dark') : Color.Black)
            .copyOption(CopyOptions.LocalDevice)
        }
        .gesture(
          PinchGesture({ fingers: CommonConstants.PINCH_GESTURE_FINGERS })
            .onActionUpdate((event?: GestureEvent) => {
              if (event && (this.isDetailPage || this.isPictureDetail)) {
                let tmp = this.pinchValue * event.scale;
                if (tmp > CommonConstants.MAX_SCALE) {
                  tmp = CommonConstants.MAX_SCALE;
                }
                if (tmp < CommonConstants.MIN_SCALE) {
                  tmp = CommonConstants.MIN_SCALE;
                }
                this.scaleValue = tmp;
                this.contentFontSize = CommonConstants.CONTENT_FONT_SIZE * this.scaleValue;
                this.contentFontHeight = CommonConstants.CONTENT_FONT_HEIGHT * this.scaleValue;
                this.pictureMarginTop = CommonConstants.PICTURE_MARGIN_TOP * (this.scaleValue > 1 ? this.scaleValue : 1);
              }
            })
            .onActionEnd(() => {
              this.pinchValue = this.scaleValue;
            })
        )

        if (this.showPicture) {
          if (this.cardItem.pictureArray.length === 1) {
            Image(this.cardItem.pictureArray[0])
              .onComplete((event: ImageInfo) => {
                if (event.width < event.height) {
                  this.imageWidth = CommonConstants.HALF_PERCENT;
                }
              })
              .width(this.imageWidth)
              .onClick(() => {
                this.jump(0);
              })
              .margin({ top: `${this.pictureMarginTop}${CommonConstants.SUFFIX_VP}` })
          } else {
            Grid() {
              ForEach(this.cardItem.pictureArray, (item: Resource, index: number) => {
                GridItem() {
                  Image(item)
                    .width(CommonConstants.FULL_PERCENT)
                    .aspectRatio(1)
                    .onClick(() => {
                      this.jump(index);
                    })
                    .autoResize(true)
                }
              }, (item: Resource, index: number) => index + JSON.stringify(item))
            }
            .columnsTemplate(CommonConstants.GRID_COLUMNS_TEMPLATE)
            .columnsGap($r('app.float.grid_gap'))
            .rowsGap($r('app.float.grid_gap'))
            .width(CommonConstants.FULL_PERCENT)
            .aspectRatio(this.getAspectRatio(this.cardItem.pictureArray.length))
            .margin({ top: `${this.pictureMarginTop}${CommonConstants.SUFFIX_VP}` })
          }
        }
      }
    }
    .alignItems(HorizontalAlign.Start)
    .flexShrink(1)
    .width(CommonConstants.FULL_PERCENT)
  }

  getAspectRatio(length: number): number {
    let rowNumber: number = (length % CommonConstants.MAX_GRID_COLUMN === 0) ? length / CommonConstants.MAX_GRID_COLUMN :
      (Math.floor(length / CommonConstants.MAX_GRID_COLUMN) + 1);
    return CommonConstants.MAX_GRID_COLUMN / rowNumber;
  }
}