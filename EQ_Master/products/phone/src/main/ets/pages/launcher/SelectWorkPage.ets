import { router } from '@kit.ArkUI';
import { CommonConstants } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';

@Entry
@Component
export struct SelectWorkPage {
 @State private selectedJob: string = ""; // 单选
 @State private selectedCommunicationInWork: string[] = []; // 复选
  private jobList: string[] = ["上班族", "学生", "自由职业者", "企业家/创业者", "公务员/事业单位工作人员"]; // 定义文字数组
  private jobIcons: string[] = ['app.media.icon_worker','app.media.icon_student','app.media.icon_freelancer','app.media.icon_entrepreneur','app.media.icon_civil_servant1','app.media.icon_civil_servant2'];// 定义对应的图标数组
  private workHumanList: string[] = ["上级", "下级", "同事", "客户", "老师", "同学"];



  build() {
    Column({ space: 20 }) {
      //选取工作
      Text("您的主要工作是？")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10, left: 10 });

      Column() {
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          this.jobButton(this.jobList[0], this.jobIcons[0])
          this.jobButton(this.jobList[1], this.jobIcons[1])
          this.jobButton(this.jobList[2], this.jobIcons[2])
          this.jobButton(this.jobList[3], this.jobIcons[3])

        };

        this.longJobButton(this.jobList[4], this.jobIcons[4],this.jobIcons[5])
      }

      // **第二部分：选择沟通困难的人（多选）**
      Text("在工作中，和哪些身份的人沟通使您感到困难？")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10, left: 10 });

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.workHumanList, (person: string) => {
          this.communicationButton(person);
        });
      }.margin({ left: 5, right: 5 });

    }
    .padding(20);
  }


  // 单选按钮（主要工作）
  @Builder
  jobButton(name: string,icon: string) {
    Button({ type: ButtonType.Normal, stateEffect: true }){
      Row(){
        Image($r(icon))
          .width(45)  // 设置宽度
          .aspectRatio(1)// 设置高度
          .objectFit(ImageFit.Contain) // 保持原比例缩放
          .padding({left:0})
        Text(name).fontColor(Color.Black).padding({ right: 10 })
      }.width('100%').height(40).justifyContent(FlexAlign.SpaceBetween)// 垂直居中
    }
      .onClick(() => {
        this.selectedJob = name;
      })
      .backgroundColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.3)" : "#F7F6FE") // 透明蓝色
      .borderColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.6)" : "#DDDDDD") // 选中时边框变蓝
      .borderWidth(2)
      .type(ButtonType.Normal)
      .borderRadius(6)
      .padding({top:10 ,bottom:10})
      .margin({ bottom: 12 })
      .width("48%")
  }

  @Builder
  longJobButton(name: string,icon1: string,icon2: string) {
    Button({ type: ButtonType.Normal, stateEffect: true }){
      Row(){
        Row() {
          Image($r(icon1))
            .width(45)
            .aspectRatio(1)
            .objectFit(ImageFit.Contain)// 保持原比例缩放
            .padding({ left: 0 })
          Image($r(icon2))
            .width(45)
            .aspectRatio(1)
            .objectFit(ImageFit.Contain)// 保持原比例缩放
            .margin({ left: 0 })
        }
        Text(name).fontColor(Color.Black).padding({ right: 20 })
      }.width('100%').height(40).justifyContent(FlexAlign.SpaceBetween)// 垂直居中
    }
    .onClick(() => {
      this.selectedJob = name;
    })
    .backgroundColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.3)" : "#F7F6FE") // 透明蓝色
    .borderColor(this.selectedJob === name ? "rgba(102, 153, 255, 0.6)" : "#DDDDDD") // 选中时边框变蓝
    .borderWidth(2)
    .type(ButtonType.Normal)
    .borderRadius(6)
    .padding({top:10 ,bottom:10})
    .margin({ bottom: 20 })
    .width("100%")
  }

  // 多选按钮（沟通困难）
  @Builder
  communicationButton(name: string) {
    Button(name)
      .fontColor(Color.Black)
      .onClick(() => {
        if (this.selectedCommunicationInWork.includes(name)) {
          this.selectedCommunicationInWork = this.selectedCommunicationInWork.filter(item => item !== name);
        } else {
          this.selectedCommunicationInWork.push(name);
        }
      })
      .backgroundColor(this.selectedCommunicationInWork.includes(name) ? "rgba(102, 153, 255, 0.3)" : "#F7F6FE") // 透明蓝色
      .borderColor(this.selectedCommunicationInWork.includes(name) ? "rgba(102, 153, 255, 0.6)" : "#DDDDDD")
      .borderWidth(2)
      .type(ButtonType.Normal)
      .borderRadius(6)
      .padding(10)
      .margin({ bottom: 12 })
      .width("48%")
      .height(55);
  }
}