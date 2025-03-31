import { CommonConstants } from '../common/constants/CommonConstants';
import PromptUtil from '../common/utils/PromptUtil';
import HuksModel from '../model/HuksModel';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/utils/Logger';
import { util } from '@kit.ArkTS';
import PreferenceModel from '../model/PreferenceModel';
import UserAuthModel from '../model/UserAuthModel';
import UserServer from '../server/user/UserServer';
import { UserInfo } from '../server/user/UserData';
import ResponseResult from '../server/ResponseResult';

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

@Component
export struct RegisterPage {
  @State isShowFace: boolean = false;
  @State isShowFingerprint: boolean = false;
  @State isRegisterAvailable: boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private name: string = '';
  private telephone: string = '';
  private passWord: string = '';
  private confirmPassWord: string = '';
  @Consume('isFace') isFace : boolean;
  @Consume('isFingerprint') isFingerprint: boolean;
  private keyAlias: string = CommonConstants.LOGIN_KEYS;

  /**
   * Check whether the registration button can be clicked.
   */
  isRegister() {
    this.isRegisterAvailable = false;
    if (this.name.length > 0 && this.telephone.length > 0 && this.passWord.length > 0 && this.confirmPassWord.length > 0) {
      this.isRegisterAvailable = true;
    }
  }

  /**
   * Process the registration process.
   */
  async register() {
    if (!this.name) {
      PromptUtil.promptMessage($r('app.string.message_user_name'), CommonConstants.PROMPT_DURATION);
      return;
    }
    if (!this.telephone) {
      PromptUtil.promptMessage($r('app.string.message_email_prompt'), CommonConstants.PROMPT_DURATION);
    }
    if (!this.passWord || this.passWord !== this.confirmPassWord) {
      PromptUtil.promptMessage($r('app.string.message_password_prompt'), CommonConstants.PROMPT_DURATION);
      return;
    }

    UserServer.postUserSignup(this.name, this.telephone, this.passWord).then((data: UserInfo) => {
      PromptUtil.promptMessage($r('app.string.success_signup_prompt'), CommonConstants.PROMPT_DURATION);
      // Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + data.sessionId);
      // if (data.sessionId !== null) {
      //   PreferenceModel.putPreference(CommonConstants.PREFERENCES_KEY_SESSION, data.sessionId);
      //   let sessionId = PreferenceModel.getPreference(CommonConstants.PREFERENCES_KEY_SESSION, 'null');
      //   Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + sessionId);
      // }
      this.pageInfos.pop();
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

  build() {
    NavDestination() {
      Row() {
        Column() {
          Image($r('app.media.back'))
            .width($r('app.float.back_image_size'))
            .margin({ top: '15%' , left: '-93%', bottom: '0%'})
            .onClick(
              () => {
                this.pageInfos.pop();
              }
            )
          Image($r('app.media.signup_title'))
            .width('20%')
            .margin({ top: '8%' , left: '-69%', bottom: '0%'})
          Image($r('app.media.login_logo'))
            .width($r('app.float.logo_image_size'))
            .height($r('app.float.logo_image_size'))
            .margin({
              top: '13%',
              bottom: '3%'
            })
          // Text($r('app.string.register_page'))
          //   .fontSize($r('app.float.title_text_size'))
          //   .fontWeight(FontWeight.Medium)
          //   .fontColor($r('app.color.title_text_color'))


          Column() {
            TextInput({ placeholder: $r('app.string.register_name')})
              .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
              .type(InputType.USER_NAME)
              .inputStyle()
              .onChange((value: string) => {
                this.name = value;
                this.isRegister();
              })

            Line().lineStyle()

            TextInput({ placeholder: $r('app.string.register_telephone')})
              .maxLength(CommonConstants.INPUT_TELEPHONE_LENGTH)
              .type(InputType.PhoneNumber)
              .inputStyle()
              .onChange((value: string) => {
                this.telephone = value;
                this.isRegister();
              })

            Line().lineStyle()

            TextInput({ placeholder: $r('app.string.register_password')})
              .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
              .type(InputType.NEW_PASSWORD)
              .inputStyle()
              .onChange((value: string) => {
                this.passWord = value;
                this.isRegister();
              })

            Line().lineStyle()

            TextInput({ placeholder: $r('app.string.register_confirm_password')})
              .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
              .type(InputType.NEW_PASSWORD)
              .inputStyle()
              .onChange((value: string) => {
                this.confirmPassWord = value;
                this.isRegister();
              })
          }
          .backgroundColor(Color.White)
          .width('95%')
          .borderRadius($r('app.float.input_border_radius'))
          .padding({
            top: $r('app.float.input_padding_top'),
            bottom: $r('app.float.input_padding_top'),
            left: $r('app.float.input_padding_left'),
            right: $r('app.float.input_padding_left')
          })
          .margin({
            top: $r('app.float.register_margin_top')
          })

          // if (this.isShowFace) {
          //   Row() {
          //     Checkbox()
          //       .selectedColor($r('app.color.register_checkbox'))
          //       .onChange((value: boolean) => {
          //         this.isFace = value;
          //       })
          //     Text($r('app.string.register_face_checkbox'))
          //       .fontSize($r('app.float.small_text_size'))
          //       .fontWeight(FontWeight.Medium)
          //       .fontColor($r('app.color.register_text_color'))
          //   }
          //   .width(CommonConstants.FULL_PARENT)
          //   .margin({
          //     top: $r('app.float.face_margin_top'),
          //     left: $r('app.float.face_margin_left')
          //   })
          // }
          //
          // if (this.isShowFingerprint) {
          //   Row() {
          //     Checkbox()
          //       .selectedColor($r('app.color.register_checkbox'))
          //       .onChange((value: boolean) => {
          //         this.isFingerprint = value;
          //       })
          //     Text($r('app.string.register_fingerprint_checkbox'))
          //       .fontSize($r('app.float.small_text_size'))
          //       .fontWeight(FontWeight.Medium)
          //       .fontColor($r('app.color.register_text_color'))
          //   }
          //   .width(CommonConstants.FULL_PARENT)
          //   .margin({
          //     top: $r('app.float.fingerprint_margin_top'),
          //     left: $r('app.float.face_margin_left')
          //   })
          // }

          Button($r('app.string.register_button'), { type: ButtonType.Capsule })
            .width(CommonConstants.BUTTON_WIDTH)
            .height($r('app.float.login_button_height'))
            .fontSize($r('app.float.button_text_size'))
            .fontWeight(FontWeight.Medium)
            .backgroundColor(
              this.isRegisterAvailable ? $r('app.color.login_button_color') : $r('app.color.button_color_unavailable')
            )
            .margin({
              top: $r('app.float.register_button_top'),
              bottom: $r('app.float.button_bottom')
            })
            .enabled(this.isRegisterAvailable)
            .onClick(async () => {
              await this.register();
            })

          Text('')
            .height('5%')
          Text($r('app.string.eq_master_introduce'))
            .height(CommonConstants.LAUNCHER_TEXT_INTRODUCE_HEIGHT)
              // .width("100%")
            .eqMasterTextStyle(FontWeight.Normal,
              CommonConstants.LAUNCHER_TEXT_INTRODUCE_SPACING,
              $r('app.float.signup_text_introduce_size'),
              $r('app.color.signup_text_introduce_color'))
            .opacity(0.8)
            .margin({ top: CommonConstants.LAUNCHER_TEXT_INTRODUCE_MARGIN_TOP })
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
    .hideTitleBar(true)
    .onAppear(() => {
      HuksModel.isKeyItemExist(this.keyAlias)
        .then((isExist) => {
          if (!isExist) {
            HuksModel.generateKeyItem(this.keyAlias);
          }
        })
        .catch((error: BusinessError) => {
          Logger.error(CommonConstants.TAG, `huks keys not generate ${error.code} ${error.message}`);
          HuksModel.generateKeyItem(this.keyAlias);
        })
      this.isShowFace = UserAuthModel.isFaceAvailable();
      this.isShowFingerprint = UserAuthModel.isFingerprintAvailable();
      this.isFace = false;
      this.isFingerprint = false;
    })
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