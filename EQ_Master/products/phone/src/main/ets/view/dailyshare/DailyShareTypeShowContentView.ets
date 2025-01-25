import { DailyShare } from '../../server/dailyshare/DailyShareData';
// import CardArrayViewModel from '../../viewmodel/CardArrayViewModel';
import { CardArray } from '../../viewmodel/CardArrayViewModel';
import { router } from '@kit.ArkUI';
import { CommonConstants } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';
import { preferences } from '@kit.ArkData';
import PreferenceModel from '../../model/PreferenceModel';
import { HotColumnView } from './HotColumnView';
import { CardItem } from '../../viewmodel/CardViewModel';
import { MircoBlogView } from './MircoBlogView';
import { CommentBarView } from './CommentBarView';
import { DailyShareIndex } from './DailyShareIndex';
import { DailyShareItem } from '../../common/constants/DailyShareList';
import { COMMENT_LIST } from '../../model/CommentModel';
import { CommentItemInterface } from '../../viewmodel/CommentViewModel';
import { CommentItem } from '../../viewmodel/CommentViewModel';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';
import { BreakpointType } from '../../common/constants/BreakpointType';

@Entry
@Component
export struct DailyShareTypeShowContentView {

  // private dailyShareListByPopularity: Array<DailyShareItem> = [];
  @Consume dailyShareListByPopularity: Array<DailyShare>;
  @Consume dailyShareListByTime: Array<DailyShare>

  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = new CardArray(this.dailyShareListByTime);
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State tabIndexSelected: number = 0;

  jumpDetail(dailyShareId: string) {
    PreferenceModel.putPreference('dailyShareId', dailyShareId);

    router.pushUrl({
      url: CommonConstants.DAILY_SHARE_DETAIL_PAGE_URL
    }).catch((error: Error) => {
      Logger.error(CommonConstants.DAILY_SHARE_DETAIL_PAGE_TAG, 'DailyShareShowTypePage pushUrl error ' + JSON.stringify(error));
    });
  }

  getCardArray(dailyShareListByTime: Array<DailyShare>): CardItem[] {
    let cardArray: CardItem[] = [];
    dailyShareListByTime.forEach((item: DailyShare) => {
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
      });
      cardArray.push(cardItem);
    });
    return cardArray;
  }

  // @Builder
  // TitleBarBuilder() {
  //   Row() {
  //     List({
  //       // space: new BreakpointType(Common.WINDOW_PADDING_SM, Common.WINDOW_PADDING_MD,
  //       //   Common.WINDOW_PADDING_LG).getValue(this.currentBreakpoint)
  //     })
  //     {
  //       ForEach(CommonConstants.RANK_TITLE_LIST, (item: ResourceStr, index: number) => {
  //         ListItem() {
  //           Text(item)
  //             .fontSize($r('app.float.rank_name_fs'))
  //             .fontWeight(CommonConstants.FONT_WEIGHT_500)
  //             .fontColor(this.tabIndexSelected === index ? $r('app.color.tab_selected') : $r('app.color.tab_normal'))
  //             .height($r('app.float.rank_name_height'))
  //             .onClick(() => {
  //               this.tabIndexSelected = index;
  //             })
  //         }
  //       }, (item: string, index: number) => index + JSON.stringify(item))
  //     }
  //     .listDirection(Axis.Horizontal)
  //     .height($r('app.float.rank_title_height'))
  //     .alignListItem(ListItemAlign.Center)
  //     .scrollBar(BarState.Off)
  //   }
  //   .width(CommonConstants.FULL_PERCENT)
  //   .justifyContent(this.currentBreakpoint !== Breakpoint.BREAKPOINT_SM ? FlexAlign.SpaceBetween : FlexAlign.Start)
  //   .padding({
  //     left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
  //       $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
  //     right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
  //       $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
  //     top: $r('app.float.tab_bar_padding_top')
  //   })
  // }

  build() {
    Scroll() {
      Column() {
        // this.TitleBarBuilder()

        // Tabs({ index: this.tabIndexSelected, barPosition: BarPosition.Start }) {
        //   ForEach(CommonConstants.RANK_TITLE_LIST, (item: ResourceStr) => {
        //     TabContent() {
        //       HotColumnView({
        //         tab_index: this.tabIndexSelected
        //       })
        //     }
        //   }, (item: string) => JSON.stringify(item))
        // }
        // .barMode(BarMode.Scrollable, { margin: $r('app.float.tab_bar_mode_margin') })
        // .barHeight($r('app.float.tab_bar_height'))
        // .animationDuration(Common.TAB_ANIMATION_DURATION)
        // .scrollable(false)
        // .barHeight($r('app.float.zero'))
        // .height($r('app.float.rank_list_height'))
        // .padding({
        //   left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        //     $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
        //   right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        //     $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
        // })

        HotColumnView()
          .height('-20%')

        Blank()
          .width(CommonConstants.FULL_PERCENT)
          .height($r('app.float.blank_height'))
          // .visibility(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? Visibility.Hidden : Visibility.Visible)

        WaterFlow() {
          ForEach(this.getCardArray(this.dailyShareListByTime), (item: CardItem) => {
            FlowItem() {
              Column() {
                MircoBlogView({
                  cardItem: item,
                  // index: index,
                  jumpDetail: () => {
                    // AppStorage.setOrCreate('selectCardIndex', index);
                    this.jumpDetail(item.dailyShareId);
                  }
                })
                  .padding({
                    // left: new BreakpointType($r('app.float.window_padding_left_sm'),
                    //   $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_sm'))
                    //   .getValue(this.currentBreakpoint),
                    // right: new BreakpointType($r('app.float.window_padding_left_sm'),
                    //   $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_sm'))
                    //   .getValue(this.currentBreakpoint),
                    // top: new BreakpointType($r('app.float.zero'), $r('app.float.zero'),
                    //   $r('app.float.card_margin_top_lg')).getValue(this.currentBreakpoint)
                    left: $r('app.float.window_padding_left_sm'),
                    right: $r('app.float.window_padding_left_sm'),
                    // top: $r('app.float.card_margin_top_lg')
                  })

                CommentBarView({
                  isShowInput: false,
                  jumpDetail: () => {
                    // AppStorage.setOrCreate('selectCardIndex', index);
                    this.jumpDetail(item.dailyShareId);
                  }
                })
              }
              // .borderRadius(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
              // $r('app.float.water_flow_br') : $r('app.float.zero'))
              .borderRadius($r('app.float.zero'))
              .backgroundColor($r('app.color.white'))
              // .margin(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
              // $r('app.float.water_flow_margin') : $r('app.float.zero'))
              .margin($r('app.float.zero'))
            }
          }, (item: CardItem, index: number) => index + JSON.stringify(item))
        }
        // .backgroundColor(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
        // $r('app.color.water_flow_bgc_lg') : $r('app.color.water_flow_bgc'))
        .backgroundColor($r('app.color.water_flow_bgc'))
        .linearGradient({
          angle: CommonConstants.LINEAR_GRADIENT_ANGEL,
          colors: [
            [CommonConstants.LINEAR_GRADIENT_FROM_COLOR, 0],
            [CommonConstants.LINEAR_GRADIENT_TO_COLOR, CommonConstants.LINEAR_GRADIENT_TO_AREA]
          ]
        })
        // .rowsGap(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
        // $r('app.float.zero') : $r('app.float.water_flow_rows_gap'))
        .rowsGap($r('app.float.water_flow_rows_gap'))
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.SELF_FIRST
        })
        // .columnsTemplate(this.currentBreakpoint !== Breakpoint.BREAKPOINT_LG ?
        // CommonConstants.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL : CommonConstants.WATER_FLOW_COLUMNS_TEMPLATE_LG)
        .columnsTemplate(CommonConstants.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL)
        // .padding({
        //   left: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_lg') :
        //   $r('app.float.zero'),
        //   right: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_lg') :
        //   $r('app.float.zero'),
        //   top: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_top_lg') :
        //   $r('app.float.zero')
        // })
        .padding({
          left: $r('app.float.zero'),
          right: $r('app.float.zero'),
          top: $r('app.float.zero')
        })
      }
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }
}