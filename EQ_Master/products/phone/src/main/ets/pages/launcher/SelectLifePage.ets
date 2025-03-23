import { router } from "@kit.ArkUI";
import { CommonConstants } from "../../common/constants/CommonConstants";
import Logger from "../../common/utils/Logger";

@Entry
@Component
export struct SelectLifePage {
  @State private selectedCommunicationInLife: string[] = []; // 复选
  private lifeHumanList: string[] = ["子女、其他后辈", "父母、其他长辈", "兄弟/姐妹", "伴侣", "朋友", "陌生人"];

  build() {
    Column({ space: 20 }){
      Text("在生活中，和哪些身份的人沟通使您感到困难？")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .margin({top:50, bottom: 10, left: 10 });

    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(this.lifeHumanList, (person: string) => {
        this.communicationButton(person);
      });
    }.margin({ left: 5, right: 5 });

    Button('选好了')
      .fontSize(18)
      .onClick(() => {
        // UserServer.postUserLogin(this.account, this.password).then((data: UserInfo) => {
        //   PromptUtil.promptMessage($r('app.string.success_login_prompt'), CommonConstants.PROMPT_DURATION);
        //   Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + data.sessionId);
        //   if (data.sessionId !== null) {
        //     PreferenceModel.putPreference(CommonConstants.PREFERENCES_KEY_SESSION, data.sessionId);
        //     let sessionId = PreferenceModel.getPreference(CommonConstants.PREFERENCES_KEY_SESSION, 'null');
        //     Logger.info(CommonConstants.PREFERENCES_KEY_SESSION + ' : ' + sessionId);
        //   }
        //   router.pushUrl({
        //     url: CommonConstants.APP_HOME_PAGE_URL
        //   }).catch((error: Error) => {
        //     Logger.error(CommonConstants.APP_HOME_PAGE_TAG, 'HomePage pushUrl error ' + JSON.stringify(error));
        //   });
        // }).catch((err: Resource | ResponseResult) => {
        //   if (err instanceof ResponseResult) {
        //     if (err.message !== null) {
        //       PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        //     }
        //   } else {
        //     PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
        //   }
        // })
      })


      .width('90%')
      .height(50)
      .margin({bottom:10})
      Stack() {
        Image($r('app.media.icon_person1'))  // 第一张图片
          .width('70%')
          .aspectRatio(1)// 设置高度
          .objectFit(ImageFit.Contain) // 保持原比例缩放
          .position({ right:150, top: 0 })  // 设置图片的绝对位置
          .zIndex(1)  // 控制层级

        Image($r('app.media.icon_person2'))  // 第二张图片
          .width('70%')
          .aspectRatio(1)// 设置高度
          .objectFit(ImageFit.Contain) // 保持原比例缩放
          .position({ left: 50, top: 0})  // 设置第二张图片稍微偏移，叠加
          .zIndex(2)  // 控制层级

        Image($r('app.media.icon_person3'))  // 第三张图片
          .width('70%')
          .aspectRatio(1)// 设置高度
          .objectFit(ImageFit.Contain) // 保持原比例缩放
          .position({ left: 150, top: 6})  // 设置第三张图片稍微偏移，叠加
          .zIndex(3)  // 控制层级
      }
      .width('90%')
      // .height('50%')


  }
  .padding(20);
  }


  // 多选按钮（沟通困难）
  @Builder
  communicationButton(name: string) {
    Button(name)
      .fontColor(Color.Black)
      .onClick(() => {
        if (this.selectedCommunicationInLife.includes(name)) {
          this.selectedCommunicationInLife = this.selectedCommunicationInLife.filter(item => item !== name);
        } else {
          this.selectedCommunicationInLife.push(name);
        }
      })
      .backgroundColor(this.selectedCommunicationInLife.includes(name) ? "rgba(102, 153, 255, 0.3)" : "#F7F6FE")// 透明蓝色
      .borderColor(this.selectedCommunicationInLife.includes(name) ? "rgba(102, 153, 255, 0.6)" : "#DDDDDD")
      .borderWidth(2)
      .type(ButtonType.Normal)
      .borderRadius(6)
      .padding(10)
      .margin({ bottom: 12 })
      .width("48%")
      .height(55);
  }
}