import { CommonConstants } from '../common/constants/CommonConstants';
import { router, window } from '@kit.ArkUI';
import PreferenceModel from '../model/PreferenceModel';
import PromptUtil from '../common/utils/PromptUtil';
import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/utils/Logger';
import { RegisterPage } from '../view/login/RegisterPage';
import { EmailLoginPage } from '../view/login/EmailLoginPage'
import { httpRequestGet } from '../common/utils/HttpUtil';
import { httpRequestPost } from '../common/utils/HttpUtil';
import ResponseResult from '../server/ResponseResult';
import UserServer from '../server/user/UserServer';
import { UserInfo } from '../server/user/UserData';

/**
 * 这些函数定义了 TextInput、Line 和 Text 组件的样式，使用了 @Extend 装饰器来扩展这些组件的样式。
 */
@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor(Color.White)
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text)
function blueTextStyle() {
  .fontColor($r('app.color.login_blue_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}

/**
 * Login Page.
 */
@Entry
@Component
struct LoginPage {
  // @State 表示这些变量是组件的状态。
  @State account: string = '';
  @State password: string = '';
  // @Provide 表示这些变量可以被子组件注入。
  @Provide('isFace') isFace: boolean = true;
  @Provide('isFingerprint') isFingerprint: boolean = true;
  @State isLogin: boolean = false;
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  // @StorageLink 表示 userLogin 变量与存储中的 userLogin 关联。
  @StorageLink('userLogin') userLogin: boolean = false;
  // private keyAlias 是一个私有变量，用于存储登录密钥的别名。
  private keyAlias: string = CommonConstants.LOGIN_KEYS;

  /**
   * onPageShow 方法在页面显示时调用，设置窗口的隐私模式，并从 PreferenceModel 中获取面部识别和指纹识别的偏好设置。
   */
  onPageShow() {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      windowStage.setWindowPrivacyMode(true);
    });
    this.isFace = PreferenceModel.getPreference(CommonConstants.IS_SHOW_FACE, true) as boolean;
    this.isFingerprint = PreferenceModel.getPreference(CommonConstants.IS_SHOW_FINGERPRINT, true) as boolean;
  }

  /**
   * onPageHide 方法在页面隐藏时调用，设置窗口的隐私模式。
   */
  onPageHide(): void {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      windowStage.setWindowPrivacyMode(false);
    });
  }

  /**
   * @Builder 装饰器表示这是一个页面映射函数。
   * PagesMap 函数根据传入的 name 参数返回相应的页面组件。如果 name 为 register，则返回 RegisterPage。
   * @param name
   */
  @Builder
  PagesMap(name: string) {
    if (name === 'register') {
      RegisterPage()
    }
    else if(name == 'emailLogin'){
      EmailLoginPage()
    }
  }

  /**
   * isLoginAvailable 方法检查 account 和 password 是否都已输入，以确定登录按钮是否可用。
   */
  isLoginAvailable() {
    this.isLogin = false;
    if (this.account.length > 0 && this.password.length > 0) {
      this.isLogin = true;
    }
  }

  /**
   * login 方法处理登录逻辑
   */
  // TODO 异步？
  login() {
    if (this.account === '' || this.password === '') {
      PromptUtil.promptMessage($r('app.string.input_empty_tips'), CommonConstants.PROMPT_DURATION);
      return;
    }

    UserServer.postUserLogin(this.account, this.password).then((data: UserInfo) => {
      PromptUtil.promptMessage($r('app.string.success_login_prompt'), CommonConstants.PROMPT_DURATION);
      Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + data.sessionId);
      if (data.sessionId !== null) {
        PreferenceModel.putPreference(CommonConstants.PREFERENCES_KEY_SESSION, data.sessionId);
        let sessionId = PreferenceModel.getPreference(CommonConstants.PREFERENCES_KEY_SESSION, 'null');
        Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + sessionId);
      }
      router.pushUrl({
        url: CommonConstants.APP_HOME_PAGE_URL
      }).catch((error: Error) => {
        Logger.error(CommonConstants.APP_HOME_PAGE_TAG, 'HomePage pushUrl error ' + JSON.stringify(error));
      });
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

  /**
   * userAuthResult 方法处理用户认证结果，如果认证成功，则设置 userLogin 为 true，并导航到主页面
   * Operations After a User Is Successfully Authenticated.
   * @param Whether the user authentication is successful.
   */
  userAuthResult: (isSuccess: boolean) => void = (isSuccess: boolean) => {
    if (isSuccess) {
      this.userLogin = true;
      router.replaceUrl({
        url: 'pages/MainPage'
      });
    }
  }

  build() {
    Navigation(this.pageInfos) {
      Column() {
        Image($r('app.media.login_logo'))
          .width($r('app.float.logo_image_size'))
          .height($r('app.float.logo_image_size'))
          .margin({
            top: $r('app.float.logo_margin_top'),
            bottom: $r('app.float.logo_margin_bottom')
          })
        Image($r('app.media.login_title'))
          .width('70%')
          .margin({ top: '11%' , bottom: '0.3%'})
        // Text($r('app.string.login_page'))
        //   .fontSize($r('app.float.title_text_size'))
        //   .fontWeight(FontWeight.Medium)
        //   .fontColor($r('app.color.title_text_color'))
        Text($r('app.string.eq_master_introduce'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.login_text_color'))
          .margin({
            bottom: $r('app.float.login_bottom'),
            top: $r('app.float.login_top')
          })

        Column() {
          TextInput({ placeholder: $r('app.string.email') })
            .type(InputType.Email)
            .inputStyle()
            .onChange((value: string) => {
              this.account = value;
              this.isLoginAvailable();
            })

          Line().lineStyle()

          TextInput({ placeholder: $r('app.string.password') })
            .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
            .type(InputType.Password)
            .inputStyle()
            .onChange((value: string) => {
              this.password = value;
              this.isLoginAvailable();
            })
        }
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.input_border_radius'))
        .width('95%')
        .padding({
          top: $r('app.float.input_padding_top'),
          bottom: $r('app.float.input_padding_top'),
          left: $r('app.float.input_padding_left'),
          right: $r('app.float.input_padding_left')
        })

        Row() {
          Text($r('app.string.message_login')).blueTextStyle()
            .onClick(() => {
              this.pageInfos.pushPathByName('emailLogin', null);
            })
          Text($r('app.string.forgot_password')).blueTextStyle()
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(CommonConstants.FULL_PARENT)
        .padding({
          top: $r('app.float.forgot_margin_top'),
          left: $r('app.float.forgot_margin_left'),
          right: $r('app.float.forgot_margin_right')
        })

        Button($r('app.string.login'), { type: ButtonType.Capsule })
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.button_text_size'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isLogin ? $r('app.color.login_button_color') : $r('app.color.button_color_unavailable'))
          .margin({
            top: $r('app.float.button_top'),
            bottom: $r('app.float.button_bottom')
          })
          .enabled(this.isLogin)
          .onClick(() => {
            this.login();
          })
        Text($r('app.string.register_account'))
          .fontColor($r('app.color.login_blue_color'))
          .fontSize('15fp')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.pageInfos.pushPathByName('register', null);
          })

        Blank()

        // if (this.isFace || this.isFingerprint) {
        //   Text($r('app.string.other_login_method'))
        //     .fontColor($r('app.color.other_login_color'))
        //     .fontSize($r('app.float.little_text_size'))
        //     .fontWeight(FontWeight.Medium)
        //     .margin({
        //       top: $r('app.float.other_margin_top'),
        //       bottom: $r('app.float.other_margin_bottom')
        //     })
        //   Row({ space: CommonConstants.LOGIN_METHODS_SPACE }) {
        //     if (this.isFace) {
        //       Button({ type: ButtonType.Circle, stateEffect: true }) {
        //         Image($r('app.media.face'))
        //       }
        //       .height($r('app.float.other_image_size'))
        //       .width($r('app.float.other_image_size'))
        //       .backgroundColor($r('app.color.background'))
        //       .onClick(() => {
        //         UserAuthModel.getFaceAuth(this.userAuthResult);
        //         UserAuthModel.start();
        //       })
        //     }
        //
        //     if (this.isFingerprint) {
        //       Button({ type: ButtonType.Circle, stateEffect: true }) {
        //         Image($r('app.media.touchid'))
        //       }
        //       .height($r('app.float.other_image_size'))
        //       .width($r('app.float.other_image_size'))
        //       .backgroundColor($r('app.color.background'))
        //       .onClick(() => {
        //         UserAuthModel.getFingerprintAuth(this.userAuthResult);
        //         UserAuthModel.start();
        //       })
        //     }
        //   }
        // }
      }
      .backgroundColor($r('app.color.background'))
      .height(CommonConstants.FULL_PARENT)
      .width(CommonConstants.FULL_PARENT)
      .padding({
        left: $r('app.float.page_padding_hor'),
        right: $r('app.float.page_padding_hor'),
        bottom: $r('app.float.login_page_bottom')
      })
    }
    .navDestination(this.PagesMap)
    .hideTitleBar(true)
    .hideToolBar(true)
    .mode(NavigationMode.Stack)
    .backgroundColor($r('app.color.background'))
  }
}