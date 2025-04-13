import { StandardIcon } from './StandardIcon';
import { BaseConstants } from '../../common/constants/BaseConstants';

@Component
export struct AIAgentIntro {

  private cardInfo: Array<Array<string>> =[
    ["智能体1主标题","智能体1副标题","app.media.AIAgent_1_Big","0","0%"],
    ["智能体2主标题","智能体2副标题","app.media.AIAgent_2_Big","0","0%"],
    ["智能体3主标题","智能体3副标题","app.media.AIAgent_3_Big","0","0%"]
  ]

  @Builder
  AIAgentCard(cardInfo:Array<Array<string>>,offset:number){
    Column() {
      Stack() {
        Column() {
          Text(cardInfo[offset][0])
            .fontColor(0x00000000)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .padding({ top: 10 })
          Text(cardInfo[offset][1])
            .fontColor(0x00000000)
            .fontSize(12)
            .padding({ top: 10 })
        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        Column() {
          Text("→")
            .fontColor(0x00000000)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .margin({ right: 16 })
        }
        .alignItems(HorizontalAlign.End)
        .justifyContent(FlexAlign.End)
        .width('100%')
        .height('100%')
      }
    }
    .onClick(() => { console.log("button1") })
    .margin({ top: 10, bottom: 10 })
    .backgroundColor(0x00FFFFFF)
    .backgroundImage($r(cardInfo[offset][2]))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundImagePosition({ x: cardInfo[offset][3], y: cardInfo[offset][4] })
    .borderRadius(20)
    //.borderWidth(1)
    .width('80%')
    .height(160)
  }

  build(){
    Scroll() {
      Column() {
        this.AIAgentCard(this.cardInfo,0)
        this.AIAgentCard(this.cardInfo,1)
        this.AIAgentCard(this.cardInfo,2)
      }
    }
    .align(Alignment.Center)
    .width('100%')
    .height('100%')
  }
}