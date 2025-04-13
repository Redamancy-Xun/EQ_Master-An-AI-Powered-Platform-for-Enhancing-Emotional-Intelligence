import { CommonConstants } from '../../common/constants/CommonConstants';
import { HotListItemView } from './HotListItemView';
import { HotItem} from '../../model/HotModel';
import Logger from '../../common/utils/Logger'
import DailyShareServer from '../../server/dailyshare/DailyShareServer'
import {DailyShare} from '../../server/dailyshare/DailyShareData'
import ResponseResult from '../../server/ResponseResult';
import PromptUtil from '../../common/utils/PromptUtil';
import { PICTURE_MAP } from '../../common/constants/PictureConstants';
import { Converter, dailyShareToHotItemConverter } from '../../model/Converter';

@Component
export struct HotListView {
  @State dailyShareListByPopularity:Array<DailyShare> = []
  max_count:number = 15
  index: number = 0;
  groupTitle: ResourceStr = '';

  switchType(){
    switch (this.index){
      case 0:
        return 'tip'
      case 1:
        return 'story'
      case 2:
        return 'question'
      default:
        return 'unknown'
    }
  }

  getDailyShareListByPopularity(type: string, page: number, pageSize: number, orderByPopularity: boolean){ // 函数本身就有赋值, 故删除返回值,
    Logger.info(CommonConstants.DAILY_SHARE_TYPE_PAGE_TAG,
      'getDailyShare page: ' + page + ' pageSize: ' + pageSize + ' type: ' + type + ' orderByPopularity: ' +
        orderByPopularity);
    DailyShareServer.getDailyShareTypeList(type, page, pageSize, orderByPopularity).then((data: Array<DailyShare>) => {
      this.dailyShareListByPopularity= data;
    }).catch((err: Resource | ResponseResult) => {
      if (err instanceof ResponseResult) {
        if (err.message !== null) {
          PromptUtil.promptMessage(err.message, CommonConstants.PROMPT_DURATION);
        }
      } else {
        PromptUtil.promptMessage(err, CommonConstants.PROMPT_DURATION);
      }
    })
  }

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

  @Builder
  itemHeader() {
    Row() {
      Text(this.groupTitle)
        .fontSize($r('app.float.group_item_title_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_BOLD)
        .fontColor($r('app.color.group_item_title_font_color'))
        .margin({ left: $r('app.float.group_item_title_ml') })
    }
    .height($r('app.float.group_item_title_height'))
    .margin({ top: $r('app.float.group_item_title_mt') })
    .justifyContent(FlexAlign.Start)
  }

  async aboutToAppear(){
    // this.dailyShareListByPopularity = await DailyShareServer.getDailyShareTypeList(this.switchType(),1,this.max_count,false)
    this.getDailyShareListByPopularity(this.switchType(), 1, this.max_count, false)
    //tip/story/question
  }

  build() {
    Row() {
      List() {
        ListItemGroup({ header: this.itemHeader() }) {
          ForEach(this.switchToHotItemArray(), (item: HotItem) => {
          // ForEach(HOST_LIST_ARRAY[this.index], (item: HotItemInterface) => {
            // 此处index是HotList的类型, 一个类型中有一组HotListItem, 但这里先省略. 全部都用一个HotList
            ListItem() {
              HotListItemView({
                item: item,
                indexWidth: $r('app.float.index_width_more')
              })
            }
          }, (item: HotItem) => JSON.stringify(item))
        }
      }
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .edgeEffect(EdgeEffect.None)
      .padding({
        left: $r('app.float.hot_list_pl')
      })
    }
    .borderRadius($r('app.float.rank_list_rd'))
    .backgroundColor($r('app.color.white'))
  }
}