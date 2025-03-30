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
export struct selectPeopleInWork{
  @State private selectedPeopleInWork: string[] = []; // 复选
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isNextStepAvailable: boolean = false;
  private peopleList: string[] = ["上级", "下级", "同事", "客户", "老师", "同学"];

  aboutToAppear(){
    PreferenceModel.getPreferencesFromStorage()
    this.selectedPeopleInWork =  PreferenceModel.getPreference(CommonConstants.SELECTED_PEOPLE_IN_WORK,[]) as string[];
    this.isNextStep();
  }


  /**
   * Check whether the registration button can be clicked.
   */
  isNextStep() {
    this.isNextStepAvailable = false;
    if (this.selectedPeopleInWork.length>0 ) {
      this.isNextStepAvailable = true;
    }
  }

  // 多选按钮（沟通困难）
  @Builder
  peopleButton(name: string) {
    Button(name)
      .fontColor($r('app.color.placeholder_color'))
      .onClick(() => {
        if (this.selectedPeopleInWork.includes(name)) {
          this.selectedPeopleInWork = this.selectedPeopleInWork.filter(item => item !== name);
          PreferenceModel.putPreference(CommonConstants.SELECTED_PEOPLE_IN_WORK,this.selectedPeopleInWork)
          this.isNextStep()

        } else {
          this.selectedPeopleInWork.push(name);
          PreferenceModel.putPreference(CommonConstants.SELECTED_PEOPLE_IN_WORK,this.selectedPeopleInWork)
          this.isNextStep()
        }
      })
      .backgroundColor(this.selectedPeopleInWork.includes(name) ? "rgba(102, 153, 255, 0.3)" : Color.White) // 透明蓝色
      .borderColor(this.selectedPeopleInWork.includes(name) ? "rgba(102, 153, 255, 0.3)" : Color.White)
      .borderWidth(2)
      .type(ButtonType.Normal)
      .borderRadius(6)
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

        Text($r('app.string.ask_people_in_work'))
          .fontSize('24vp')
          .fontWeight(700)
          .margin({
            top: '15%',
            bottom: '3%'
          })
        .width('90%')
        .textAlign(TextAlign.Start)

        Column(){
          this.peopleButton(this.peopleList[0])
          this.peopleButton(this.peopleList[1])
          this.peopleButton(this.peopleList[2])
          this.peopleButton(this.peopleList[3])
          this.peopleButton(this.peopleList[4])
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
            top: '60vp',
            bottom: $r('app.float.button_bottom')
          })
          .enabled(this.isNextStepAvailable)
          .onClick(
            () => {
              this.pageInfos.pushPathByName('selectPeopleInLife', null)
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