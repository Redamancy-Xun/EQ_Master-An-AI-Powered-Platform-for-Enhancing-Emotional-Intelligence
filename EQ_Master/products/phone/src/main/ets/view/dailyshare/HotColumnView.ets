import { CommonConstants } from '../../common/constants/CommonConstants';
import { DailyShareItem } from '../../common/constants/DailyShareList';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';
import { HotItem} from '../../model/HotModel';
import { DailyShare } from '../../server/dailyshare/DailyShareData';
import { HotListItemView } from './HotListItemView';
import Logger from '../../common/utils/Logger'
import router from '@ohos.router';
import preferenceModel from '../../model/PreferenceModel'
import { Converter, dailyShareToHotItemConverter } from '../../model/Converter';

const SWIPER_LIST: number[] = [0, 1, 2];

// @Entry
@Component
export struct HotColumnView {
  // @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  // @State tab_index: number = 0;
  @Consume dailyShareListByPopularity: Array<DailyShare>
  @State HotItemList:Array<HotItem>=[]

  switchToHotItemArray(): Array<HotItem> {
    let hotItemList: Array<HotItem> = [];
    let count:number = 1;
    let converter:Converter<DailyShare,HotItem> = new dailyShareToHotItemConverter()
    this.dailyShareListByPopularity.forEach((item: DailyShare) => {
      let hotItem: HotItem = converter.convert(item)
      hotItemList.push(hotItem);
      count++;
    })
    return hotItemList;
  }

  // aboutToAppear(): void {
  //   this.switchToHotItemInterface()
  //   AppStorage.setOrCreate('HotItemList',this.HotItemList)
    // 以下是测试, 在日志中筛选here
    // let tmp:Array<HotItemInterface>|undefined=AppStorage.get('HotItemList')
    // Logger.info('here!'+JSON.stringify(tmp))
  // }


  @Builder
  HotListBuilder(index: number) { //将hotItemList转换成列表形式展示
    List() {
      // ForEach(this.HotItemList, (item: HotItemInterface) => {
      ForEach(this.switchToHotItemArray(), (item: HotItem) => {
        ListItem() {
          HotListItemView({
            item: item,
            showDetail: true,
            indexWidth: item.index <= CommonConstants.HOT_COLUMN_MAX_COUNT ? $r('app.float.index_width_normal') :
              $r('app.float.index_width_more'),
            indexIconGap: $r('app.float.index_icon_gap')
          })
        }
      }, (item: HotItem) => JSON.stringify(item))
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
      Row(){
        Text('查看完整榜单')
          .fontWeight(FontWeight.Normal)
          .fontColor($r('app.color.read_total_rank_color'))
          .fontSize($r('app.float.read_total_rank_fs'))

        Image($r('app.media.ic_public_arrow_right_filled'))
          .width($r('app.float.arrow_right_width'))
          .aspectRatio(1)
          .margin({ left: $r('app.float.arrow_right_ml') })
          .opacity(0.4)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .margin({ top: $r('app.float.read_total_rank_mt') })
      .onClick(() => {
        router.pushUrl({
          // 转到热度榜的详情页
          url:'pages/dailyshare/HotRankPage',//此处以加入pages配置中
        }).catch((error: Error) => {
          Logger.error('HotColumnView pushUrl error ' + JSON.stringify(error));
        }).then(()=> { //成功跳转信息
          Logger.info('HotColumnView pushUrl success')
        })
      })

    }
    .width(CommonConstants.FULL_PERCENT)
    .alignItems(HorizontalAlign.Start)

  }
}