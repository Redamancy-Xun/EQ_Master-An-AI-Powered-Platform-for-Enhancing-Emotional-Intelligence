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
import { COMMENT_LIST } from '../../model/CommentModel';
import { CommentItemInterface } from '../../viewmodel/CommentViewModel';
import { CommentItem } from '../../viewmodel/CommentViewModel';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';

@Component
export struct DailyShareTypeShowContentView {

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

  build() {
    Scroll() {
      Column() {
        HotColumnView()
          .height('-20%')

        Blank()
          .width(CommonConstants.FULL_PERCENT)
          .height($r('app.float.blank_height'))

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
                    left: $r('app.float.window_padding_left_sm'),
                    right: $r('app.float.window_padding_left_sm'),
                  })

                CommentBarView({
                  isShowInput: false,
                  jumpDetail: () => {
                    // AppStorage.setOrCreate('selectCardIndex', index);
                    this.jumpDetail(item.dailyShareId);
                  }
                })
              }

              .borderRadius($r('app.float.zero'))
              .backgroundColor($r('app.color.white'))
              .margin($r('app.float.zero'))
            }
          }, (item: CardItem, index: number) => index + JSON.stringify(item))
        }
        .backgroundColor($r('app.color.water_flow_bgc'))
        .linearGradient({
          angle: CommonConstants.LINEAR_GRADIENT_ANGEL,
          colors: [
            [CommonConstants.LINEAR_GRADIENT_FROM_COLOR, 0],
            [CommonConstants.LINEAR_GRADIENT_TO_COLOR, CommonConstants.LINEAR_GRADIENT_TO_AREA]
          ]
        })
        .rowsGap($r('app.float.water_flow_rows_gap'))
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.SELF_FIRST
        })
        .columnsTemplate(CommonConstants.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL)
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