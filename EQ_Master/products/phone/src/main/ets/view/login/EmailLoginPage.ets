import { CommonConstants } from '../../common/constants/CommonConstants';
import PromptUtil from '../../common/utils/PromptUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../../common/utils/Logger';
import { util } from '@kit.ArkTS';
import PreferenceModel from '../../model/PreferenceModel';
import UserServer from '../../server/user/UserServer';
import { UserInfo } from '../../server/user/UserData';
import ResponseResult from '../../server/ResponseResult';
import { Prompt, router } from '@kit.ArkUI';

@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor(Color.White)
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT})
  .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Component
export struct EmailLoginPage {
  @State isLogin: boolean = false;
  private email: string = '';   // 存储邮箱
  private verificationCode:string = '';
  @State private countdown: number = 0; // 倒计时（秒）
  private timer: number | null = null; // 计时器 ID
  // @StorageLink 表示 userLogin 变量与存储中的 userLogin 关联。
  @StorageLink('userLogin') userLogin: boolean = false;

  /**
   * isLoginAvailable 方法检查 email 和 verificationCode 是否都已输入，以确定登录按钮是否可用。
   */
  isLoginAvailable() {
    this.isLogin = false;
    if (this.email.length > 0  && this.verificationCode.length > 0 ) {
      this.isLogin = true;
    }
  }

  // 发送验证码的逻辑
  sendCode() {

    if (this.countdown > 0) return // 若在倒计时，不允许点击

    if (!this.validateEmail(this.email)) {
      Prompt.showToast({ message: "请输入有效的邮箱", duration: 2000 })
      return
    }

    // 发送验证码请求（需要后端接口）
    console.log(`Sending verification code  !!!`)


    // 开始倒计时
    this.startCountdown()


  }

  // 倒计时逻辑
  startCountdown() {
    this.countdown = 60 // 设置倒计时 60s
    this.timer = setInterval(() => {
      if (this.countdown > 0) {
        this.countdown -= 1
      } else {
        clearInterval(this.timer!) // 清除计时器
        this.timer = null
      }
    }, 1000)
  }

  // 邮箱格式校验
  validateEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return emailRegex.test(email)
  }


  /**
   * login 方法处理登录逻辑
   */
  // 登录  需要修改
  login() {
    if (this.email === '' || this.verificationCode === '') {
      PromptUtil.promptMessage($r('app.string.input_empty_tips'), CommonConstants.PROMPT_DURATION);
      return;
    }

    UserServer.postUserLogin(this.email, this.verificationCode).then((data: UserInfo) => {
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
    NavDestination() {
      Row() {
        Column() {

          Image($r('app.media.login_logo'))
            .width($r('app.float.logo_image_size'))
            .height($r('app.float.logo_image_size'))
            .margin({
              top: $r('app.float.logo_margin_top_new'),
              bottom: $r('app.float.logo_margin_bottom')
            })
          Image($r('app.media.login_title'))
            .width('70%')
            .margin({ top: '11%' , bottom: '0.3%'})

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
              this.email = value;
              this.isLoginAvailable();
            })

            Line().lineStyle()


            Row() {
              Stack({alignContent:Alignment.End}){
                TextInput({ placeholder: $r('app.string.email_message') })
                  .type(InputType.Number)
                  .inputStyle()
                .onChange((value: string) => {
                  this.verificationCode = value;
                  this.isLoginAvailable();
                })
                Text(this.countdown > 0 ? `${this.countdown} 秒后重新获取` : $r('app.string.acquire'))
                  .fontColor(this.countdown > 0 ? Color.Gray : $r('app.color.theme_color'))
                  .fontSize($r('app.float.font_size'))
                  .fontWeight(FontWeight.Medium)
                  // .fontColor($r('app.color.theme_color'))
                  .padding({ left: CommonConstants.INPUT_PADDING_LEFT})
                  .margin({ top: $r('app.float.input_margin_top') })
                  .onClick(() => this.sendCode())
                  .enabled(this.countdown === 0)

              }
            }
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


          Button($r('app.string.login'), { type: ButtonType.Capsule })
            .width(CommonConstants.BUTTON_WIDTH)
            .height($r('app.float.login_button_height'))
            .fontSize($r('app.float.button_text_size'))
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.isLogin ? $r('app.color.login_button_color') : $r('app.color.button_color_unavailable'))
            .margin({
              top:115,
              bottom: $r('app.float.button_bottom')
            })
            .enabled(this.isLogin)
            .onClick(() => {
              this.login();
            })


        }
        .backgroundColor($r('app.color.background'))
        .height('110%')
        .width(CommonConstants.FULL_PARENT)
        .padding({
          left: $r('app.float.page_padding_hor'),
          right: $r('app.float.page_padding_hor'),
          bottom: $r('app.float.login_page_bottom')
        })
      }
      .height('CommonConstants.FULL_PARENT')
    }
    .height('110%')

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