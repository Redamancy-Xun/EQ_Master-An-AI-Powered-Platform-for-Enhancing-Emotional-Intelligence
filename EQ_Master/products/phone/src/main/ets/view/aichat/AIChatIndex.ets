import ConversationDetailItem from './ConversationDetailItem';
import { ConversationDetailTopSearch } from './ConversationDetailTopSearch';
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

  // TODO 聊天记录的储存

  aiChat(prompt: string) {
    console.log("prompt: " + prompt);
    AIChatServer.getAIChat(prompt).then((result: string) => {
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

  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column }) {
        ConversationDetailTopSearch()
          .height(Adaptive.ContactItemHeight(this.currentBreakpoint))
        Scroll() {
          Column() {
            ForEach(this.conversationDetailItems, (item: string, index: number) => {
              ConversationDetailItem({
                // todo
                isReceived: index % 2 !== 0,
                content: item,
              })
            })
          }
        }
        Blank()
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