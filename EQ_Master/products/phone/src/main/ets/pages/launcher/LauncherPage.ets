import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { router, window } from '@kit.ArkUI';
import Logger from '../../common/utils/Logger';
import { CommonConstants } from '../../common/constants/CommonConstants';
import CustomDialogComponent from '../../view/login/CustomDialogComponent';
import { GlobalContext } from '../../common/utils/GlobalContext';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@ohos.base';
import UserServer from '../../server/user/UserServer';
import ResponseResult from '../../server/ResponseResult';
import PromptUtil from '../../common/utils/PromptUtil';

/**
 * The LauncherPage is the entry point of the application and shows how to develop the LauncherPage.
 * Stay on the LauncherPage for a few seconds to jump to the AdvertisingPage.
 * Developers can replace the background image.
 */
@Entry
@Component
struct LauncherPage {
  // @StorageProp('bottomRectHeight')
  // bottomRectHeight: number = 0;
  // @StorageProp('topRectHeight')
  // topRectHeight: number = 0;

  // 私有属性只能在类内访问
  private context?: common.UIAbilityContext;    // context：存储 UIAbility 的上下文，可能是 undefined
  private timerId: number = 0;                  // timerId：一个定时器的 ID，用于管理跳转到广告页面
  private isJumpToAdvertising: boolean = false; // isJumpToAdvertising：一个布尔值，表示是否已经跳转到广告页面
  // 用来管理对话框的创建、显示、隐藏、以及与用户交互的逻辑
  dialogController: CustomDialogController = new CustomDialogController({
    // builder：定义了对话框的结构，包括取消和确认按钮的回调函数
    builder: CustomDialogComponent(
      {
        // 定义了用户点击取消按钮时，触发的回调函数
        cancel: () => {
          this.onCancel();
        },
        // 确认按钮时触发的回调函数
        confirm: () => {
          this.onConfirm();
        }
      }),
    alignment: DialogAlignment.Bottom,// 对话框对齐到屏幕的底部
    offset: { dx: 0, dy: CommonConstants.DIALOG_CONTROLLER_DY_OFFSET },
    customStyle: true,
    autoCancel: false
  });

  // 当用户点击取消按钮时调用，终止应用程序
  onCancel() {
    // Exit the application.
    this.context?.terminateSelf();
  }

  // 当用户点击确认按钮时调用，保存隐私设置并跳转到广告页面
  onConfirm() {
    // Save privacy agreement status.
    this.saveIsPrivacy();
    this.jumpToAdvertisingPage();
  }

  // 在页面隐藏时调用，清除路由并停止定时器
  onPageHide() {
    if (this.isJumpToAdvertising) {
      router.clear();
    }
    // globalThis.isJumpPrivacy = true;
    GlobalContext.getContext().setObject('isJumpPrivacy', true);
    clearTimeout(this.timerId);
  }

  // TODO 后期把跳转转为组件跳转
  /**
   * 设置一个定时器，在指定时间后跳转到广告页面
   */
  jumpToAdvertisingPage() {
    this.timerId = setTimeout(() => {
      this.isJumpToAdvertising = true;

      this.getDataPreferences(this).then((preferences: preferences.Preferences) => {
        preferences.get(CommonConstants.PREFERENCES_KEY_FIRST_USER, true).then((value: preferences.ValueType) => {
          Logger.info(CommonConstants.LAUNCHER_PAGE_TAG, 'jump to : ' + value ? 'FirstPage' : 'Login');
          if (value) {
            this.saveIsFirstUse();
            router.pushUrl({
              // url: CommonConstants.ADVERTISING_PAGE_URL
              url: CommonConstants.FIRST_PAGE_URL
            }).catch((error: Error) => {
              Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'LauncherPage pushUrl error ' + JSON.stringify(error));
            });
          } else {
            preferences.get(CommonConstants.PREFERENCES_KEY_SESSION, '').then((value: preferences.ValueType) => {
              Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + value);
              console.log(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + value);
              if (value == '') {
                router.pushUrl({
                  url: CommonConstants.LOGIN_PAGE_URL
                }).catch((error: Error) => {
                  Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'LauncherPage pushUrl error ' + JSON.stringify(error));
                });
              } else {
                // todo checkLogin
                UserServer.getCheckLogin().then((result: number) => {
                  if (result == 0) {// TODO 对此处临时调整可以强制更改session
                    router.pushUrl({
                      url: CommonConstants.APP_HOME_PAGE_URL
                    }).catch((error: Error) => {
                      Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'LauncherPage pushUrl error ' + JSON.stringify(error));
                    });
                  } else {
                    router.pushUrl({
                      url: CommonConstants.LOGIN_PAGE_URL
                    }).catch((error: Error) => {
                      Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'LauncherPage pushUrl error ' + JSON.stringify(error));
                    })
                  }
                }).catch((err: Resource | ResponseResult) => {
                  if (err instanceof ResponseResult) {
                    if (err.message !== null) {
                      PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
                    }
                  } else {
                    PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
                  }
                })
              }
            })
          }
        });
      });
     }, CommonConstants.LAUNCHER_DELAY_TIME);
  }

  // 将用户隐私设置保存到偏好设置中
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

  // 将用户是否为第一次使用APP保存到偏好设置中
  saveIsFirstUse() {
    let preferences: Promise<preferences.Preferences> = this.getDataPreferences(this); //获得用户偏好设置数据，第一次使用/非第一次使用
    preferences.then((result: preferences.Preferences) => {
      let firstUsePut = result.put(CommonConstants.PREFERENCES_KEY_FIRST_USER, false);
      result.flush();
      firstUsePut.then(() => {
        Logger.info(CommonConstants.LAUNCHER_PAGE_TAG, 'Put the value of startup Successfully.');
      }).catch((err: Error) => {
        Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'Put the value of startup Failed, err: ' + err);
      });
    }).catch((err: Error) => {
      Logger.error(CommonConstants.LAUNCHER_PAGE_TAG, 'Get the preferences Failed, err: ' + err);
    });
  }

  // 在页面显示时调用，获取用户偏好设置并根据隐私设置决定是否显示对话框
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
   * 获取用户的偏好设置
   */
  getDataPreferences(common: Object) {
    return preferences.getPreferences(getContext(common), CommonConstants.PREFERENCES_NAME);
  }
  //
  // onWindowStageCreate(windowStage: window.WindowStage): void {
  //   // Main window is created, set main page for this ability
  //   hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
  //
  //   windowStage.loadContent('pages/Index', (err) => {
  //     if (err.code) {
  //       hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
  //       return;
  //     }
  //     hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
  //   });
  //   // 获取应用主窗口
  //   let windowClass: window.Window = windowStage.getMainWindowSync();
  //   // 设置窗口全屏
  //   let isLayoutFullScreen = true;
  //   windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
  //     console.info('Succeeded in setting the window layout to full-screen mode.');
  //   }).catch((err: BusinessError) => {
  //     console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
  //   });
  //   //获取导航栏高度
  //   let bottomRectHeight = windowClass
  //     .getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
  //     .bottomRect
  //     .height;
  //   AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight);
  //   // 获取状态栏区域高度
  //   let topRectHeight = windowClass
  //     .getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
  //     .topRect
  //     .height;
  //   AppStorage.setOrCreate('topRectHeight', topRectHeight);
  //
  //   // 注册监听函数，动态获取避让区域数据
  //   windowClass.on('avoidAreaChange', (data) => {
  //     if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
  //       let topRectHeight = data.area.topRect.height;
  //       AppStorage.setOrCreate('topRectHeight', topRectHeight);
  //     } else if (data.type == window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
  //       let bottomRectHeight = data.area.bottomRect.height;
  //       AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight);
  //     }
  //   });
  // }


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
        Text('')
          .height('42%')
        Text($r('app.string.eq_master_introduce'))
          .height(CommonConstants.LAUNCHER_TEXT_INTRODUCE_HEIGHT)
          // .width("100%")
          .eqMasterTextStyle(FontWeight.Medium,
            CommonConstants.LAUNCHER_TEXT_INTRODUCE_SPACING,
            $r('app.float.launcher_text_introduce_size'),
            $r('app.color.launcher_text_introduce_color'))
          .opacity($r('app.float.launcher_text_opacity'))
          .margin({ top: CommonConstants.LAUNCHER_TEXT_INTRODUCE_MARGIN_TOP })
      }
      .height(CommonConstants.FULL_HEIGHT)
      .width(CommonConstants.FULL_WIDTH)
      // top数值与状态栏区域高度保持一致；bottom数值与导航条区域高度保持一致
      // .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
      .backgroundColor($r('app.color.start_window_background'))
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