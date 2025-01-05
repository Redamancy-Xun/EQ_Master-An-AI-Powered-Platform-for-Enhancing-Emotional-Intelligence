import { CommonConstants } from '../../common/constants/CommonConstants';
import { DailyShareItem, findDailyShareItemById } from '../../common/constants/DailyShareList';
import { COMMENT_LIST } from '../../model/CommentModel';
import PreferenceModel from '../../model/PreferenceModel';
import { CardArray } from '../../viewmodel/CardArrayViewModel';
import { CardItem } from '../../viewmodel/CardViewModel';
import { CommentItem, CommentItemInterface } from '../../viewmodel/CommentViewModel';
import { CommentBarView } from './CommentBarView';
import { CommentItemView } from './CommentItemView';

@Component
export struct CommentListView {
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  // @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = new CardArray([]);
  @StorageProp('selectCardIndex') selectCardIndex: number = 0;
  focusHide?: boolean = false;
  commentPadding?: ResourceStr;
  isDarkMode: boolean = false;

  @Builder
  itemHead() {
    Row() {
      Text($r('app.string.comment_list_title'))
        .fontSize($r('app.float.comment_list_title_fs'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .width(CommonConstants.FULL_PERCENT)
        .fontColor(this.isDarkMode ? Color.White : Color.Black)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.comment_list_title_height'))
    .padding({
      top: $r('app.float.tab_bar_padding_top')
    })
  }

  getComments(): CommentItemInterface[] {
    let commentList: CommentItemInterface[] = [];
    COMMENT_LIST.forEach((item: CommentItemInterface) => {
      commentList.push(new CommentItem(item));
    });
    return commentList;
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          List({ space: CommonConstants.LIST_ITEM_SPACE }) {
            ForEach( this.getComments(),
              (item: CommentItemInterface) => {
                ListItem() {
                  CommentItemView({
                    commentItem: item,
                    authorName: 'EQ_Master',
                    isDarkMode: this.isDarkMode
                  })
                }
              }, (item: CommentItemInterface, index: number) => index + JSON.stringify(item))
          }
          .nestedScroll({
            // scrollForward: (this.isFoldHorizontal && this.currentBreakpoint === Breakpoint.BREAKPOINT_MD) ?
            //   NestedScrollMode.PARENT_FIRST : NestedScrollMode.PARENT_FIRST,
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.None)
          .margin({
            top: $r('app.float.tab_content_margin_top')
          })
        }
        .tabBar(this.itemHead())
        .align(Alignment.Top)
      }
      .vertical(false)
      .layoutWeight(1)
      .padding({
        left: this.commentPadding ?? this.getPadding(),
        right: this.commentPadding ?? this.getPadding()
      })

      CommentBarView()
        .visibility(this.isShow() ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.End)
  }

  isShow(): boolean {
    if (this.focusHide) {
      return false;
    }
    // if ((this.currentBreakpoint === Breakpoint.BREAKPOINT_MD && this.isFoldHorizontal) ||
    //   (this.currentBreakpoint === Breakpoint.BREAKPOINT_LG)) {
    //   return true;
    // }
    return false;
  }

  getPadding(): Resource {
    // if (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM) {
      return $r('app.float.window_padding_left_sm');
    // }
    // if (this.currentBreakpoint === Breakpoint.BREAKPOINT_MD) {
    //   if (this.isFoldHorizontal) {
    //     return $r('app.float.window_padding_left_sm');
    //   } else {
    //     return $r('app.float.window_padding_left_md');
    //   }
    // }
    // return $r('app.float.window_padding_left_lg');
  }
}