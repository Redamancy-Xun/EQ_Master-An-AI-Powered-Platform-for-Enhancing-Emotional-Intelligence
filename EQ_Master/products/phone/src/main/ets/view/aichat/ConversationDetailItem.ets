import { HomeConstants } from '../../common/constants/HomeConstants';
import { MessageBubble } from './MessageBubble';

@Component
export default struct ConversationDetailItem {
  // private currentFeatureIndex: number = 0;
  // private receivedName: string = '';
  public isReceived: boolean = !HomeConstants.IS_RECEIVED;
  public content: ResourceStr = '';
  public isAppletMsg?: boolean;
  public isDocumentMsg?: boolean;

  build() {
    Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.End }) {
      MessageBubble({
        // receivedName: this.receivedName,
        // currentFeatureIndex: this.currentFeatureIndex,
        isReceived: this.isReceived,
        content: this.content,
        isAppletMsg: this.isAppletMsg,
        isDocumentMsg: this.isDocumentMsg
      })
    }
  }
}