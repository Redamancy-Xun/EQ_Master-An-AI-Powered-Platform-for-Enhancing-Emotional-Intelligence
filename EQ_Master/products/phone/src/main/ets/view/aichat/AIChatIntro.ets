import { StandardIcon } from './StandardIcon';
import { BaseConstants } from '../../common/constants/BaseConstants';
import AIChatServer from '../../server/aichat/AIChatServer';
import PromptUtil from '../../common/utils/PromptUtil';
import ResponseResult from '../../server/ResponseResult';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { AIChatIndex } from './AIChatIndex';

@Component
export struct AIChatIntro{

  @Link private conversationDetailItems: Array<string>
  @Link private scrollUpdate: boolean;
  @Link private isUsed_1:boolean;

  aiChat(prompt: string) {
    console.log("prompt: " + prompt);
    AIChatServer.getAIChat(prompt).then((result: string) => {
      this.scrollUpdate=true;
      this.isUsed_1=true;
      this.conversationDetailItems.push(result);
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
      this.conversationDetailItems.push("wrong!!!");
    })
  }

  @Builder
  predefinedQuestions(question:string){
    Text(question)
      .onClick(() => {
        this.conversationDetailItems.push(question)
        this.aiChat(question)
      })
      .margin({ top: 20, left: 20 })
      .backgroundColor(0x00FFFFFF)
      .borderRadius(5)
      .width('auto')
      .height(40)
      .padding({ left:10, right:10 })
      .border({width: 1, color: 0x00C0C0C0, radius: 10})
  }

  build(){
    Column(){
      Column({space:10}) {
        Image($r('app.media.EQ_Master_icon'))
          .margin({ top: '1%', bottom: '1.9%' })
          .height(50)
        Text("Hi, I'm EQMasterChatBot")
          .fontWeight(BaseConstants.FONT_WEIGHT_FIVE)
          .fontSize(BaseConstants.FONT_SIZE_EIGHTEEN)
          .fontWeight(FontWeight.Bolder)
          .fontColor($r('app.color.conversation_default_text_color'))
          .margin({ left: "2%", bottom: "3%" })
          .textAlign(TextAlign.Center)
        Text("How can I help you today?")
          .fontWeight(BaseConstants.FONT_WEIGHT_FIVE)
          .fontSize(BaseConstants.FONT_SIZE_EIGHTEEN)
          .fontColor(0x00808080)
          .margin({ left: "2%", bottom: "3%" })
          .textAlign(TextAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      this.predefinedQuestions("预设提问1")
      this.predefinedQuestions("预设提问2")
      this.predefinedQuestions("预设提问3")
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }

}