import { CommonConstants } from '../../common/constants/CommonConstants';
import { DailyShareItem } from '../../common/constants/DailyShareList';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';
import { HotItemInterface } from '../../model/HotModel';
import { DailyShare } from '../../server/dailyshare/DailyShareData';
import { HotListItemView } from './HotListItemView';

const SWIPER_LIST: number[] = [0, 1, 2];

@Component
export struct HotColumnView {
  // @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  // @State tab_index: number = 0;
  dailyShareListByPopularity: Array<DailyShareItem> = [];

  switchToHotItemInterface(): Array<HotItemInterface> {
    let hotItemList: Array<HotItemInterface> = [];
    let count: number = 1;
    this.dailyShareListByPopularity.forEach((item: DailyShareItem) => {
      let hotItem: HotItemInterface = {
        index: count,
        icon: PICTURE_MAP.get(item.picture? item.picture : ''),
        dailyShareId: item.id ? item.id : '',
        title: item.title ? item.title : '',
        content: item.context ? item.context : '',
        stateIcon: $r('app.media.ic_state_fire'),
        clickCount: item.likes + item.view + item.commentCount + item.favorite + item.share,
        upDownIcon: $r('app.media.ic_up')
      };
      hotItemList.push(hotItem);
      count++;
    })
    return hotItemList;
  }

  @Builder
  HotListBuilder(index: number) {
    List() {
      ForEach(this.switchToHotItemInterface(), (item: HotItemInterface) => {
        ListItem() {
          HotListItemView({
            item: item,
            showDetail: true,
            indexWidth: item.index <= CommonConstants.HOT_COLUMN_MAX_COUNT ? $r('app.float.index_width_normal') :
              $r('app.float.index_width_more'),
            indexIconGap: $r('app.float.index_icon_gap')
          })
        }
      }, (item: HotItemInterface) => JSON.stringify(item))
    }
  }

  build() {
    Column() {
      Swiper() {
        ForEach(SWIPER_LIST, (item: number) => {
          this.HotListBuilder(item)
        }, (item: number) => JSON.stringify(item))
      }
      .autoPlay(false)
      .indicator(false)
      .disableSwipe(true)
      // .displayCount(new BreakpointType(
      //   CommonConstants.SWIPER_DISPLAY_COUNT_ONE,
      //   CommonConstants.SWIPER_DISPLAY_COUNT_TWO,
      //   CommonConstants.SWIPER_DISPLAY_COUNT_THREE
      // ).getValue(this.currentBreakpoint))
      // .itemSpace((new BreakpointType(CommonConstants.HOT_COLUMN_IS_SM, CommonConstants.HOT_COLUMN_IS_MD, CommonConstants.HOT_COLUMN_IS_LG))
      //   .getValue(this.currentBreakpoint))

      // TODO 完整榜单，见：MultiCommunityApplication-master [D:\Harmony\source\MultiCommunityApplication-master]
      // ToRankView()
    }
    .width(CommonConstants.FULL_PERCENT)
    .alignItems(HorizontalAlign.Start)
  }
}