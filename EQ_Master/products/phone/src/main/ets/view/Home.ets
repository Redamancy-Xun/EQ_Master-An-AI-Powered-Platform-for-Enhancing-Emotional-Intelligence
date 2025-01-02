/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

/**
 * Home tab content.
 */
import {CommonConstants} from '../common/constants/CommonConstants';
import ItemData from '../model/ItemDataModel';
import mainViewModel from '../viewmodel/MainViewModel';

@Component
export default struct Home {
  private swiperController: SwiperController = new SwiperController();
  
  build() {
    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        Swiper(this.swiperController) {
          ForEach(mainViewModel.getSwiperImages(), (img: Resource) => {
            Image(img).borderRadius($r('app.float.home_swiper_radius'))
          })
        }
        .margin({ top:$r('app.float.home_swiper_margin') })
        .autoPlay(true)

        Grid() {
          ForEach(mainViewModel.getFirstGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.img)
                  .width($r('app.float.home_cell_size'))
                  .height($r('app.float.home_cell_size'))
                Text(item.title)
                  .fontSize($r('app.float.little_text_size'))
                  .margin({ top: $r('app.float.home_cell_margin') })
              }
            }
          }, (item: ItemData, index: number) => index + JSON.stringify(item))
        }
        .columnsTemplate(CommonConstants.HOME_COLUMNS_TEMPLATE)
        .rowsTemplate(CommonConstants.HOME_ROWS_TEMPLATE)
        .columnsGap($r('app.float.home_grid_gap'))
        .rowsGap($r('app.float.home_row_gap'))
        .padding({
          top: $r('app.float.home_grid_padding'),
          bottom: $r('app.float.home_grid_padding')
        })
        .height($r('app.float.home_grid_height'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.home_border_radius'))

        Text($r('app.string.home_list'))
          .fontSize($r('app.float.normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .width(CommonConstants.FULL_PARENT)
          .margin({ top : $r('app.float.home_text_margin') })

        Grid() {
          ForEach(mainViewModel.getSecondGridData(), (secondItem: ItemData) => {
            GridItem() {
              Column() {
                Text(secondItem.title)
                  .fontSize($r('app.float.normal_text_size'))
                  .fontWeight(FontWeight.Medium)
                Text(secondItem.others)
                  .margin({ top: $r('app.float.home_list_margin') })
                  .fontSize($r('app.float.little_text_size'))
                  .fontColor($r('app.color.home_grid_font'))
              }
              .alignItems(HorizontalAlign.Start)
            }
            .padding({
              top: $r('app.float.home_list_padding'),
              left: $r('app.float.home_list_padding')
            })
            .borderRadius($r('app.float.home_image_radius'))
            .align(Alignment.TopStart)
            .backgroundImage(secondItem.img)
            .backgroundImageSize(ImageSize.Cover)
            .width(CommonConstants.FULL_PARENT)
            .height(CommonConstants.FULL_PARENT)
          }, (secondItem: ItemData, index: number) => index + JSON.stringify(secondItem))
        }
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.home_second_height'))
        .columnsTemplate(CommonConstants.SECOND_COLUMNS_TEMPLATE)
        .rowsTemplate(CommonConstants.SECOND_ROWS_TEMPLATE)
        .columnsGap($r('app.float.home_grid_gap'))
        .rowsGap($r('app.float.home_row_gap'))
        .margin({ bottom: $r('app.float.setting_button_bottom')})
      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}