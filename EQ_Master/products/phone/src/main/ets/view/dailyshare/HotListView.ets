// import { CommonConstants } from '../../common/constants/CommonConstants';
// import { HotListItemView } from './HotListItemView';
//
// @Component
// export struct HotListView {
//   index: number = 0;
//   groupTitle: ResourceStr = '';
//
//   @Builder
//   itemHeader() {
//     Row() {
//       Text(this.groupTitle)
//         .fontSize($r('app.float.group_item_title_font_size'))
//         .fontWeight(CommonConstants.FONT_WEIGHT_700)
//         .fontColor($r('app.color.group_item_title_font_color'))
//         .margin({ left: $r('app.float.group_item_title_ml') })
//     }
//     .height($r('app.float.group_item_title_height'))
//     .margin({ top: $r('app.float.group_item_title_mt') })
//     .justifyContent(FlexAlign.Start)
//   }
//
//   build() {
//     Row() {
//       List() {
//         ListItemGroup({ header: this.itemHeader() }) {
//           ForEach(HOST_LIST_ARRAY[this.index], (item: HotItemInterface) => {
//             ListItem() {
//               HotListItemView({
//                 item: item,
//                 indexWidth: $r('app.float.index_width_more')
//               })
//             }
//           }, (item: HotItemInterface) => JSON.stringify(item))
//         }
//       }
//       .scrollBar(BarState.Off)
//       .nestedScroll({
//         scrollForward: NestedScrollMode.PARENT_FIRST,
//         scrollBackward: NestedScrollMode.SELF_FIRST
//       })
//       .edgeEffect(EdgeEffect.None)
//       .padding({
//         left: $r('app.float.hot_list_pl')
//       })
//     }
//     .borderRadius($r('app.float.rank_list_rd'))
//     .backgroundColor($r('app.color.white'))
//   }
// }