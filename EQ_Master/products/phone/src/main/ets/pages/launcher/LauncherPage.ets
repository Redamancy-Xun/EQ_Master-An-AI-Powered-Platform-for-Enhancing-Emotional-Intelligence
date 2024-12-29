/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';
import Logger from '../../common/utils/Logger';
import CommonConstants from '../../common/constants/CommonConstants';
import CustomDialogComponent from '../../view/CustomDialogComponent';
import { GlobalContext } from '../../common/utils/GlobalContext';

/**
 * The LauncherPage is the entry point of the application and shows how to develop the LauncherPage.
 * Stay on the LauncherPage for a few seconds to jump to the AdvertisingPage.
 * Developers can replace the background image.
 */
@Entry
@Component
struct LauncherPage {
  //私有属性只能在类内访问
  private context?: common.UIAbilityContext;//？是一个可选属性，可能存在，也可能为undefined
  private timerId: number = 0;//属性类型是number，只能存储数字
  private isJumpToAdvertising: boolean = false;
  //用来管理对话框的创建、显示、隐藏、以及与用户交互的逻辑
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogComponent(
      {
        //定义了用户点击取消按钮时，触发的回调函数
        cancel: () => {
          this.onCancel();
        },
        //确认按钮时触发的回调函数
        confirm: () => {
          this.onConfirm();
        }
      }),
    alignment: DialogAlignment.Bottom,//对话框对齐到屏幕的底部
    offset: { dx: 0, dy: CommonConstants.DIALOG_CONTROLLER_DY_OFFSET },
    customStyle: true,
    autoCancel: false
  });

  onCancel() {
    // Exit the application.
    this.context?.terminateSelf();
  }

  onConfirm() {
    // Save privacy agreement status.
    this.saveIsPrivacy();
    this.jumpToAdvertisingPage();
  }

  //在页面隐藏时调用
  onPageHide() {
    if (this.isJumpToAdvertising) {
      router.clear();
    }
    // globalThis.isJumpPrivacy = true;
    GlobalContext.getContext().setObject('isJumpPrivacy', true);
    clearTimeout(this.timerId);
  }

  /**
   * Jump to advertising page.
   */
  jumpToAdvertisingPage() {
    this.timerId = setTimeout(() => {
      this.isJumpToAdvertising = true;
      router.pushUrl({
        url: CommonConstants.ADVERTISING_PAGE_URL
      }).catch((error: Error) => {
        Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'LauncherPage pushUrl error ' + JSON.stringify(error));
      });
    }, CommonConstants.LAUNCHER_DELAY_TIME);
  }

  saveIsPrivacy() {//Promise处理异步操作的对象，代表了一个可能还未完成但最终会完成的操作
    let preferences: Promise<preferences.Preferences> = this.getDataPreferences(this);//获得用户偏好设置数据，同意/不同意
    preferences.then((result: preferences.Preferences) => {//在promise成功执行时被调用，result存储偏好
      let privacyPut = result.put(CommonConstants.PREFERENCES_KEY_PRIVACY, false);//更新偏好设置中的一个特定项，将隐私设置的值改为false
      result.flush();//保存到存储中
      privacyPut.then(() => {//隐私设置成功时
        Logger.info(CommonConstants.LAUNCHER_PAGE_TAG, 'Put the value of startup Successfully.');
      }).catch((err: Error) => {//隐私设置失败时
        Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'Put the value of startup Failed, err: ' + err);
      });
    }).catch((err: Error) => {
      Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'Get the preferences Failed, err: ' + err);
    });
  }

  //在页面显示时调用
  onPageShow() {
    this.context = getContext(this) as common.UIAbilityContext;
    // Get the operation class for saving data.
    this.getDataPreferences(this).then((preferences: preferences.Preferences) => {
      preferences.get(CommonConstants.PREFERENCES_KEY_PRIVACY, true).then((value: preferences.ValueType) => {
        Logger.info(CommonConstants.LAUNCHER_PAGE_TAG, 'onPageShow value: ' + value);
        if (value) {
          // let isJumpPrivacy: boolean = globalThis.isJumpPrivacy ?? false;
          //用户隐私设置为true，而且isJumpPrivacy为false，则说明还没跳转到用户隐私设置的页面，就会跳出对话框
          let isJumpPrivacy: boolean = (GlobalContext.getContext().getObject('isJumpPrivacy') as boolean) ?? false;
          if (!isJumpPrivacy) {
            this.dialogController.open();
          }
        } else {
          this.jumpToAdvertisingPage();
        }
      });
    });
  }

  /**
   * Get data preferences action.
   */
  getDataPreferences(common: Object) {
    return preferences.getPreferences(getContext(common), CommonConstants.PREFERENCES_FILE_NAME);
  }

  // LauncherPage.ets
  // 启动页组件
  build() {
    Stack() {
      Column() {
        // 启动页logo
        Image($r('app.media.EQ_Master_icon'))
          .width($r('app.float.launcher_logo_size'))
          .height($r('app.float.launcher_logo_size'))
          .margin({ top: CommonConstants.LAUNCHER_IMAGE_MARGIN_TOP })
        // // EQ_Master文字
        // Text($r('app.string.eq_master_text'))
        //   .width($r('app.float.launcher_life_text_width'))
        //   .height($r('app.float.launcher_life_text_height'))
        //   .healthyLifeTextStyle(FontWeight.Bold,
        //     CommonConstants.LAUNCHER_LIFE_TEXT_SPACING,
        //     $r('app.float.launcher_text_title_size'),
        //     $r('app.color.launcher_text_title_color'))
        //   .margin({ top: CommonConstants.LAUNCHER_TEXT_TITLE_MARGIN_TOP })
        // EQ_Master说明
        Text($r('app.string.eq_master_introduce'))
          .height(CommonConstants.LAUNCHER_TEXT_INTRODUCE_HEIGHT)
          .eqMasterTextStyle(FontWeight.Normal,
            CommonConstants.LAUNCHER_TEXT_INTRODUCE_SPACING,
            $r('app.float.launcher_text_introduce_size'),
            $r('app.color.launcher_text_introduce_color'))
          .opacity($r('app.float.launcher_text_opacity'))
          .margin({ top: CommonConstants.LAUNCHER_TEXT_INTRODUCE_MARGIN_TOP })
      }
      .height(CommonConstants.FULL_HEIGHT)
      .width(CommonConstants.FULL_WIDTH)
      .colorBlend($r('app.color.start_window_background'))
    }
  }
}
  // EQ_Master字体公共样式
@Extend(Text) function eqMasterTextStyle (fontWeight: number,
  textAttribute: number, fontSize: Resource, fontColor: Resource) {
  .fontWeight(fontWeight)
  .letterSpacing(textAttribute)
  .fontSize(fontSize)
  .fontColor(fontColor)
}