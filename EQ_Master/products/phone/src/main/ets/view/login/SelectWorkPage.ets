import { CommonConstants } from '../../common/constants/CommonConstants';
import PromptUtil from '../../common/utils/PromptUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../../common/utils/Logger';
import { util } from '@kit.ArkTS';
import PreferenceModel from '../../model/PreferenceModel';
import UserServer from '../../server/user/UserServer';
import { UserInfo } from '../../server/user/UserData';
import ResponseResult from '../../server/ResponseResult';
import { Prompt, router, window } from '@kit.ArkUI';


@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor(Color.White)
  .width('95%')
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.input_margin_top'), bottom:$r('app.float.input_margin_top') })
}

@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Component
export struct selectWork{
  @State private selectedJob: string = ''; // 单选
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isNextStepAvailable: boolean = false;
  private jobList: string[] = ["上班族", "学生", "自由职业者", "企业家/创业者", "公务员/事业单位工作人员"]; // 定义文字数组

  aboutToAppear(){
    PreferenceModel.getPreferencesFromStorage()
    this.selectedJob =  PreferenceModel.getPreference(CommonConstants.SELECTED_JOB,'') as string;
    this.isNextStep();
  }


  /**
   * Check whether the registration button can be clicked.
   */
  isNextStep() {
    this.isNextStepAvailable = false;
    if (this.selectedJob != '') {
      this.isNextStepAvailable = true;
    }
  }

  // 单选按钮（主要工作）
  @Builder
  jobButton(name: string) {
    Button(name)
      .fontColor($r('app.color.placeholder_color'))
      .align(Alignment.Center)
      .onClick(() => {
        this.selectedJob = name;
        PreferenceModel.putPreference(CommonConstants.SELECTED_JOB, name);
        this.isNextStep()
      })
      .backgroundColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.3)" : Color.White) // 透明蓝色
      .borderColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.3)" : Color.White) // 选中时边框变蓝
      .borderWidth(2)
      .borderRadius(6)
      .type(ButtonType.Normal)
      .padding({top:5 ,bottom:5})
      .margin({ bottom: 8 })
      .width("85%")
      .height('8%')
  }

  build() {
    NavDestination() {
      Column() {
        Image($r('app.media.signup_title'))
          .width('20%')
          .margin({  left: '-69%', bottom: '0%'})

        Text($r('app.string.ask_work'))
          .fontSize('24vp')
          .fontWeight(700)
          .margin({
            top: '18%',
            bottom: '3%'
          })
          .width('85%')
          .textAlign(TextAlign.Center)

        Column(){
          this.jobButton(this.jobList[0])
          this.jobButton(this.jobList[1])
          this.jobButton(this.jobList[2])
          this.jobButton(this.jobList[3])
          this.jobButton(this.jobList[4])
        }
        .margin({top:20})



        Button($r('app.string.register_nextstep_button'), { type: ButtonType.Capsule })
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.button_text_size'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor(
            this.isNextStepAvailable ? $r('app.color.login_button_color') : $r('app.color.button_color_unavailable')
          )
          .margin({
            top: '80vp',
            bottom: $r('app.float.button_bottom')
          })
          .enabled(this.isNextStepAvailable)
          .onClick(
            () => {
              this.pageInfos.pushPathByName('selectPeopleInWork', null)
            }
          )
      }
      .padding({
        left: $r('app.float.page_padding_hor'),
        right: $r('app.float.page_padding_hor'),
        bottom: $r('app.float.login_page_bottom')
      })
    }
    .backgroundColor($r('app.color.background'))
    .height(CommonConstants.FULL_PARENT)
    .width(CommonConstants.FULL_PARENT)

  }
}