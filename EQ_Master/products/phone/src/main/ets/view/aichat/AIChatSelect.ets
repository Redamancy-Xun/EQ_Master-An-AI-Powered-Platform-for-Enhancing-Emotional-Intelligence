import { StandardIcon } from './StandardIcon';
import { BaseConstants } from '../../common/constants/BaseConstants';
import { AIChatIndex } from './AIChatIndex';

@Component
export struct AIChatSelect {

  @Link flag:number;
  @Link isFirstTime: boolean;
  updateFlag(newFlag:number){
    this.flag=newFlag
    console.log(this.flag.toString())
  }

  build(){
      Row({space: 10}){
        Text('AI助手')
          .onClick(() => {
            this.isFirstTime=false
            this.updateFlag(1)
          })
          .margin({ top: 20 })
          .textAlign(TextAlign.Center)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: this.flag===1?[
              [0x00ADD8E6, 0.0],
              [0x00FFFFFF, 1.0]
            ]:[
              [0x00FFFFFF, 0.0],
              [0x00FFFFFF, 1.0]
          ]
          })
          .borderRadius(5)
          .width('40%')
          .height(50)
          .fontColor(0x00000000)
          .fontSize(20)
          .borderWidth(1)
        Text("智能体")
          .onClick(() => {
            this.isFirstTime=false
            this.updateFlag(2)
          })
          .margin({ top: 20 })
          .textAlign(TextAlign.Center)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: this.flag===2?[
              [0x00ADD8E6, 0.0],
              [0x00FFFFFF, 1.0]
            ]:[
              [0x00FFFFFF, 0.0],
              [0x00FFFFFF, 1.0]
            ]
          })
          .borderRadius(5)
          .width('40%')
          .height(50)
          .fontColor(0x00000000)
          .fontSize(20)
          .borderWidth(1)
      }
  }
}
