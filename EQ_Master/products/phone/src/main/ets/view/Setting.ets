/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

import { CommonConstants } from '../common/constants/CommonConstants'
import ItemData from '../model/ItemDataModel'
import mainViewModel from '../viewmodel/MainViewModel'
import { router } from '@kit.ArkUI'

/**
 * Setting tab content
 */
@Component
export default struct Setting {
  @Builder settingCell(item: ItemData) {
    Row() {
      Row({ space: CommonConstants.COMMON_SPACE }) {
        Image(item.img)
          .width($r('app.float.setting_size'))
          .height($r('app.float.setting_size'))
        Text(item.title)
          .fontSize($r('app.float.normal_text_size'))
      }
      Image($r('app.media.ic_right_grey'))
        .width($r('app.float.setting_jump_width'))
        .height($r('app.float.setting_jump_height'))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.setting_cell_left'),
      right: $r('app.float.setting_cell_right')
    })
  }

  build() {
    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        Row() {
          Image($r('app.media.ic_account'))
            .width($r('app.float.setting_account_size'))
            .height($r('app.float.setting_account_size'))
          Column() {
            Text($r('app.string.setting_account_name'))
              .fontSize($r('app.float.setting_account_fontSize'))
            Text($r('app.string.setting_account_email'))
              .fontSize($r('app.float.little_text_size'))
              .margin({ top: $r('app.float.setting_name_margin')})
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: $r('app.float.setting_account_margin')})
        }
        .margin({ top: $r('app.float.setting_account_margin')})
        .alignItems(VerticalAlign.Center)
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.setting_account_height'))
        .backgroundColor(Color.White)
        .padding({ left: $r('app.float.setting_account_padding') })
        .borderRadius($r('app.float.setting_account_radius'))

        List() {
          ForEach(mainViewModel.getSettingListData(), (item: ItemData) => {
            ListItem() {
              this.settingCell(item)
            }
            .height($r('app.float.setting_list_height'))
          }, (item: ItemData, index: number) => index + JSON.stringify(item))
        }
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.list_all_height'))
        .backgroundColor(Color.White)
        .divider({
          strokeWidth: $r('app.float.setting_list_width'),
          color: Color.Grey,
          startMargin: $r('app.float.setting_list_margin'),
          endMargin: $r('app.float.list_end_margin')
        })
        .borderRadius($r('app.float.setting_list_radius'))
        .padding({
          top: $r('app.float.setting_list_padding'),
          bottom: $r('app.float.setting_list_padding')
        })

        Blank()

        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.setting_button_font'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_background'))
          .margin({ bottom: $r('app.float.setting_button_bottom')})
          .onClick(() => {
            router.replaceUrl({
              url: CommonConstants.ROUTER_LOGIN_URL
            })
          })
      }
      .height(CommonConstants.FULL_PARENT)
    }
  }
}