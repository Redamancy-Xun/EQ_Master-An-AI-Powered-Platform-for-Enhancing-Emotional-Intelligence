import ConversationDetailItem from './ConversationDetailItem';
import { ConversationDetailTopSearch } from './ConversationDetailTopSearch';
import { AIChatIntro } from './AIChatIntro';
import { AIAgentIntro } from './AIAgentIntro';
import { AIChatSelect } from './AIChatSelect';
import { HomeConstants } from '../../common/constants/HomeConstants';
import { BaseConstants } from '../../common/constants/BaseConstants';
import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants } from '../../common/constants/BreakpointConstants';
import { Adaptive } from '../../viewmodel/AdaptiveViewModel';
import { StandardIcon } from './StandardIcon';
import AIChatServer from '../../server/aichat/AIChatServer';
import ResponseResult from '../../server/ResponseResult';
import { CommonConstants } from '../../common/constants/CommonConstants';
import PromptUtil from '../../common/utils/PromptUtil';
import inputMethod from '@ohos.inputMethod';

@Extend(TextArea)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor(Color.White)
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.input_margin_top') })
}

@Component
@Entry
export struct AIChatIndex {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  // @Prop currentConversationUserName: string;
  // @Prop currentFeatureIndex: number;
  // @Consume('pageInfo') pageInfo: NavPathStack;
  @State private conversationDetailItems: Array<string> = []
  // @Builder CustomKeyboardBuilder(){}
  @State text: string = ''
  @State flag:number =1
  //用于记录处于AI助手模式还是智能体模式
  @State isUsed_1: boolean =false
  //用于记录AI助手是否问过问题
  private effect1:object=TransitionEffect.translate({x:'-100%',y:0}).animation({duration:300})
  private effect2:object=TransitionEffect.translate({x:'100%',y:0}).animation({duration:300})
  @State isFirstTime: boolean = true;
  @State mode:boolean =false;
  //false为日常聊天模式，true为AI助手
  private scroller: Scroller = new Scroller()
  @State @Watch('doScroll')scrollUpdate: boolean=false;
  doScroll(){
    if(this.scrollUpdate) {
      this.scrollToBottom()
      this.scrollUpdate=false
    }
  }

  // TODO 聊天记录的储存

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

  public scrollToBottom() {
    this.scroller.scrollTo({ xOffset: 0, yOffset: Number.MAX_SAFE_INTEGER,animation:true })
  }

  @Builder
  AIAgent(name:string,picture:string){
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(50)
          .height('100%')
          .backgroundColor(0x00436EEE)
          .borderRadius('50%')
        Image($r(picture))
          .height('80%')
          .borderRadius('50%')
      }
      .height(50)
      Text(name)
        .onClick(() => {
          console.log("button1");
        })
        .textAlign(TextAlign.Center)
        .width('20%')
        .height(30)
        .fontColor(0x00000000)
    }
    .height('100%')
    .padding({top:5, bottom:5})
  }

  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column }) {
        ConversationDetailTopSearch()
          .height(Adaptive.ContactItemHeight(this.currentBreakpoint))
        Column() {
          AIChatSelect({
            flag: this.flag,
            isFirstTime: this.isFirstTime
          })
        }
        .height('10%')
        .width('100%')
        Scroll(this.scroller) {
          Column() {
            if(this.flag===1) {
              if(!this.isUsed_1) {
                Row({space: 20}){
                  this.AIAgent("智能体1","app.media.AIAgent_1_Small")
                  this.AIAgent("智能体2","app.media.AIAgent_2_Small")
                  this.AIAgent("智能体3","app.media.AIAgent_3_Small")
                  this.AIAgent("更多","app.media.AIAgent_more_Small")
                }
                .height(80)
                .margin({ top: 20 })
                .backgroundColor(0x00ADD8E6)
                .alignItems(VerticalAlign.Center)
                .padding({left:'5%',right:'5%'})
                .transition(this.isFirstTime
                  ? TransitionEffect.IDENTITY
                  : this.effect1)
                AIChatIntro({
                  conversationDetailItems: this.conversationDetailItems,
                  scrollUpdate: this.scrollUpdate,
                  isUsed_1:this.isUsed_1
                })
                  .transition(this.isFirstTime
                    ? TransitionEffect.IDENTITY
                    : this.effect1)
              }
              ForEach(this.conversationDetailItems, (item: string, index: number) => {
                ConversationDetailItem({
                  // todo
                  isReceived: index % 2 !== 0,
                  content: item,
                })
                  .transition(this.isFirstTime
                    ? TransitionEffect.IDENTITY
                    :this.effect1)
              })
            }else if(this.flag===2) {
              AIAgentIntro()
                .transition(this.effect2)
            }
          }
        }
        .height('70%')
        Blank()
        if(this.flag===1) {
          Row() {
            StandardIcon({ icon: $r('app.media.ic_public_emoji') })
              .padding({ left: 5 })
            Text('AI高情商回复助手')
              .fontColor('#182431')
              .fontSize(16)
              .padding({ left: '5%', right: '5%' })
          }
          .margin({ bottom: '2%' })
          .height(40)
          .width('auto')
          .borderRadius(15)
          .onClick(() => {
            this.mode = !this.mode;
          })
          .backgroundColor(this.mode === false ? 0xC0C0C0 : 0x00ADD8E6)
        }
        Flex({ alignItems: ItemAlign.Center }) {
          Column() {
            StandardIcon({ icon: $r('app.media.ic_public_emoji') })
          }
          .flexBasis(HomeConstants.FLEX_BASIS_AUTO)
          .padding({
            right: $r('app.float.conversation_detail_bottom_padding'),
            left: $r('app.float.conversation_detail_bottom_padding'),
          })
          .margin({top: '8%'})

          Blank()
          Column() {
            TextArea({ placeholder: '请提出你的情商难题~', text: this.text })
              .inputStyle()
              .placeholderColor($r('app.color.text_input_default_color'))
              .caretColor($r('app.color.text_input_default_care_color'))
              .backgroundColor($r('app.color.text_input_default_background_color'))
              .borderRadius(HomeConstants.CONVERSATION_DETAIL_BOTTOM_TEXT_RADIUS)
              .flexGrow(BaseConstants.FLEX_GROW_ONE)
              .padding({ right: $r('app.float.conversation_detail_bottom_text_padding'), top: '15vp' })
              .backgroundColor(Color.White)
              .enableKeyboardOnFocus(true)
              .margin({ top: '7%'})
              // .customKeyboard(this.CustomKeyboardBuilder())
              .onChange((value: string) => {
                this.text = value
              })
              // .onSubmit((enterKey: EnterKeyType) => {
              //   // TODO 发送信息到AI模型
              //   this.conversationDetailItems.push(this.text)
              //   this.aiChat(this.text)
              //   console.log("trigger area onsubmit" + enterKey);
              // })
          }

          Column() {
            StandardIcon({ icon: $r('app.media.send') })
          }
          .padding({
            right: $r('app.float.conversation_detail_bottom_padding'),
            left: $r('app.float.conversation_detail_bottom_padding'),
          })
          .margin({top: '8%'})
          .onClick(() => {
            // TODO 发送信息到AI模型
            this.conversationDetailItems.push(this.text)
            this.aiChat(this.text)
            this.text = '';
          })
        }
        .width(BaseConstants.FULL_WIDTH)
        .height($r('app.float.conversation_detail_bottom_height'))
        .borderColor($r('app.color.hot_title_border_color'))
        .borderWidth({
          top: ($r('app.float.hot_title_border_width_normal'))
        })
      }
      .height(BaseConstants.FULL_HEIGHT)
      .width(BaseConstants.FULL_WIDTH)
      .backgroundColor($r('app.color.background_color_grey'))
      .padding({
        bottom: deviceInfo.deviceType !== BaseConstants.DEVICE_2IN1 ? $r('app.float.tab_content_pb') : $r('app.float.zero')
      })
    }
    .hideTitleBar(true)
  }
}