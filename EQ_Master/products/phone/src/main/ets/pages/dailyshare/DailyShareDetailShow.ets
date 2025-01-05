import { BreakpointConstants } from '../../common/constants/BreakpointConstants';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { DailyShareItem, findDailyShareItemById } from '../../common/constants/DailyShareList';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';
import Logger from '../../common/utils/Logger';
import PromptUtil from '../../common/utils/PromptUtil';
import { COMMENT_LIST } from '../../model/CommentModel';
import PreferenceModel from '../../model/PreferenceModel';
import { DailyShare } from '../../server/dailyshare/DailyShareData';
import DailyShareServer from '../../server/dailyshare/DailyShareServer';
import ResponseResult from '../../server/ResponseResult';
import { CommentBarView } from '../../view/dailyshare/CommentBarView';
import { CommentInputView } from '../../view/dailyshare/CommentInputView';
import { CommentListView } from '../../view/dailyshare/CommentListView';
import { DetailTitleView } from '../../view/dailyshare/DetailTitleView';
import { MircoBlogView } from '../../view/dailyshare/MircoBlogView';
import { CardArray } from '../../viewmodel/CardArrayViewModel';
import { CardItem } from '../../viewmodel/CardViewModel';
import { CommentItem } from '../../viewmodel/CommentViewModel';
import { CommentItemInterface } from '../../viewmodel/CommentViewModel';
import { Edges } from '@ohos.arkui.node';

const KEY_BACKGROUND: string = 'background';

@Entry
@Component
export struct DailyShareTypeDetailShow {
  // @StorageLink('currentBreakpointConstants') currentBreakpointConstants: string = BreakpointConstants.BreakpointConstants_SM;
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = new CardArray([]);
  @StorageLink('selectCardIndex') selectCardIndex: number = 0;
  @StorageLink('isDetailPage') isDetailPage: boolean = false;
  @StorageLink('isShowInput') isShowInput: boolean = false;
//  @State cardItem: CardItem = this.cardArrayViewModel.cardArray[this.selectCardIndex];
//   @State cardItem: CardItem = this.switchToCardItem(this.getDailyShare());
  isShowedButton?: boolean = true;

  getDailyShare() : DailyShare {
    let dailyShareId = PreferenceModel.getPreference('dailyShareId', '').toString();
    let dailyShare: DailyShare = new DailyShare();
    Logger.info(CommonConstants.DAILY_SHARE_PAGE_TAG, 'getDailyShare id: ' + dailyShareId);
    DailyShareServer.getDailyShareById(dailyShareId).then((data: DailyShare) => {
      dailyShare = data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    });
    return dailyShare;
  }

  switchToCardItem(item: DailyShareItem): CardItem {
    let cardItem: CardItem = {
      dailyShareId: item.id ? item.id : '',
      icon: $r('app.media.login_logo'),
      name: 'EQ_Master',
      authorType: 'EQ_Master官方账号',
      content: item.context ? item.context : '',
      pictureArray: [PICTURE_MAP.get(item.picture ? item.picture : '')],
      // commentList: item.commentList;
      isLike: item.isLike ? item.isLike : false,
      isStar: item.isStar ? item.isStar : false,
      isShare: item.isShare ? item.isShare : false,
      shareCount: item.share ? item.share : 0,
      likeCount: item.likes ? item.likes : 0,
      CommonCount: item.commentCount ? item.commentCount : 0,
      viewCount: item.view ? item.view : 0,
      starCount: item.favorite ? item.favorite : 0,
      createTime: item.createdAt ? item.createdAt : new Date(),
      commentList: []
    }
    COMMENT_LIST.forEach((item: CommentItemInterface) => {
      cardItem.commentList.push(new CommentItem(item));
    })
    return cardItem;
  }

  aboutToAppear() {
    this.isDetailPage = true;
  }

  build() {
    Stack() {
      Column() {
        DetailTitleView({ isShowedButton: this.isShowedButton })
        Scroll() {
          Column() {
            MircoBlogView({
              cardItem: this.switchToCardItem(findDailyShareItemById(PreferenceModel.getPreference('dailyShareId', '').toString())),
              index: this.selectCardIndex
            })
              .margin({
                top: $r('app.float.mirco_blog_mt')
              })
              .width('95%')
              .align(Alignment.Center)
              CommentListView()
            .height(CommonConstants.FULL_PERCENT)
            .width(CommonConstants.FULL_PERCENT)
          }
          // GridRow({
          //   // columns: {
          //   //   sm: BreakpointConstants.GRID_ROW_COLUMNS[2],
          //   //   md: BreakpointConstants.GRID_ROW_COLUMNS[3],
          //   //   lg: BreakpointConstants.GRID_ROW_COLUMNS[0]
          //   // }
          // })
          // {
          //   GridCol({
          //     // span: {
          //     //   sm: BreakpointConstants.GRID_COLUMN_SPANS[5],
          //     //   md: this.isFoldHorizontal ? BreakpointConstants.GRID_COLUMN_SPANS[4] : BreakpointConstants.GRID_COLUMN_SPANS[3],
          //     //   lg: BreakpointConstants.GRID_COLUMN_SPANS[0]
          //     // }
          //   })
          //   {
          //     // if ((this.isFoldHorizontal && this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_MD)) {
          //     //   Scroll() {
          //     //     MircoBlogView({
          //     //       cardItem: this.cardItem,
          //     //       index: this.selectCardIndex
          //     //     })
          //     //       .margin({
          //     //         top: $r('app.float.mirco_blog_mt')
          //     //       })
          //     //   }
          //     //   .scrollBar(BarState.Off)
          //     //   .align(Alignment.Top)
          //     //   .layoutWeight(1)
          //     // } else {
          //       MircoBlogView({
          //         cardItem: this.switchToCardItem(findDailyShareItemById(PreferenceModel.getPreference('dailyShareId', '').toString())),
          //         index: this.selectCardIndex
          //       })
          //         .margin({
          //           top: $r('app.float.mirco_blog_mt')
          //         })
          //     // }
          //   }
          //   .width(CommonConstants.FULL_PERCENT)
          //   .padding({
          //     // left: new BreakpointConstantsType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
          //     //   $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpointConstants),
          //     // right: new BreakpointConstantsType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
          //     //   $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpointConstants)
          //     left: $r('app.float.window_padding_left_sm'),
          //     right: $r('app.float.window_padding_left_sm')
          //   })
          //
          //   GridCol({
          //     span: {
          //       sm: BreakpointConstants.GRID_COLUMN_SPANS[5],
          //       md: this.isFoldHorizontal ? BreakpointConstants.GRID_COLUMN_SPANS[6] : BreakpointConstants.GRID_COLUMN_SPANS[3],
          //       lg: BreakpointConstants.GRID_COLUMN_SPANS[0]
          //     }
          //   }) {
          //     CommentListView()
          //   }
          //   .height(CommonConstants.FULL_PERCENT)
          //   .width(CommonConstants.FULL_PERCENT)
          // }
        }
        .layoutWeight(1)
        .visibility(Visibility.Visible)
        // .visibility(this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_LG ? Visibility.None : Visibility.Visible)
        .scrollBar(BarState.Off)

          CommentBarView()
            .visibility(Visibility.Visible)
            // .visibility(this.isShow() ? Visibility.Visible : Visibility.None)
            .position({ bottom: 0 })
            .layoutWeight(10)

        Column() {
          SideBarContainer() {
            Column() {
              CommentListView()
            }
            .backgroundColor($r('app.color.acetate'))

            Column() {
              Scroll() {
                MircoBlogView({
                  cardItem: this.switchToCardItem(findDailyShareItemById(PreferenceModel.getPreference('dailyShareId', '').toString())),
                  index: this.selectCardIndex
                })
                  .margin({
                    top: $r('app.float.mirco_blog_mt')
                  })
              }
              .padding({
                left: $r('app.float.window_padding_left_lg'),
                right: $r('app.float.window_padding_left_lg')
              })
              .scrollBar(BarState.Off)
            }
            .justifyContent(FlexAlign.Start)

          }
          .sideBarPosition(SideBarPosition.End)
          .showControlButton(false)
          .sideBarWidth($r('app.float.side_bar_with'))
          .minSideBarWidth($r('app.float.min_side_bar_width'))
          .maxSideBarWidth($r('app.float.max_side_bar_width'))
          .autoHide(false)
          .divider(null)
        }
        .width(CommonConstants.FULL_PERCENT)
        // .visibility(this.currentBreakpointConstants !== BreakpointConstants.BreakpointConstants_LG ? Visibility.None : Visibility.Visible)
        .visibility(Visibility.None)
        // todo
        .layoutWeight(1)
      }
      .height(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.End)
      .expandSafeArea([SafeAreaType.KEYBOARD, SafeAreaType.SYSTEM])

      if (this.isShowInput) {
        Stack() {
          Column()
            .justifyContent(FlexAlign.End)
            .width(CommonConstants.FULL_PERCENT)
            .height(CommonConstants.FULL_PERCENT)
            .backgroundColor(Color.Black)
            .opacity($r('app.float.text_input_bgc_opacity'))
            .key(KEY_BACKGROUND)
            .onClick(() => {
              AppStorage.setOrCreate('isShowInput', false);
              focusControl.requestFocus(KEY_BACKGROUND);
            })

          CommentInputView()
        }
        .alignContent(Alignment.Bottom)
      }
    }
  }

  isShow(): boolean {
    // if ((this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_MD && !this.isFoldHorizontal) ||
    //   (this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_SM)) {
    //   return true;
    // }
    // if ((this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_MD && !this.isFoldHorizontal) ||
    //   (this.currentBreakpointConstants === BreakpointConstants.BreakpointConstants_SM)) {
    //   return true;
    // }
    // return false;
    return true;
  }
}