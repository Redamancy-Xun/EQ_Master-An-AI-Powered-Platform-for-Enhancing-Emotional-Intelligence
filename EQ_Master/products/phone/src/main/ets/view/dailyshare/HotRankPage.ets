// /*
//  * Copyright (c) 2023 Huawei Device Co., Ltd.
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *     http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  */
//
// import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon, BreakpointType } from '@ohos/base';
// import { HotListView } from './HotListView';
// import { CommonConstants as Common } from '../constants/CommonConstants'
//
// const MAX_MARGIN_TOP: number = 52;
// const MIN_MARGIN_TOP: number = 46;
//
// @Component
// export struct HotRankPage {
//   @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
//   @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
//   @State titleMarginTop: number = MAX_MARGIN_TOP;
//   @State index: number = 0;
//
//   build() {
//     Column() {
//       Stack() {
//         Row()
//           .linearGradient({
//             angle: Common.LINEAR_GRADIENT_ANGLE,
//             colors: [
//               [Common.LINEAR_GRADIENT_FROM_COLOR, Common.LINEAR_GRADIENT_FROM],
//               [Common.LINEAR_GRADIENT_TO_COLOR, Common.LINEAR_GRADIENT_TO]
//             ]
//           })
//           .width(BaseCommon.FULL_PERCENT)
//           .height($r('app.float.background_height'))
//
//         Column() {
//           Column() {
//             Text($r('app.string.rank_title'))
//               .fontSize(this.titleMarginTop === MIN_MARGIN_TOP ?
//               $r('app.float.title_normal_fs') : $r('app.float.title_max_fs'))
//               .fontWeight(BaseCommon.FONT_WEIGHT_700)
//               .fontColor($r('app.color.title_font_color'))
//             Text($r('app.string.ran_sub_title'))
//               .fontSize($r('app.float.sub_title_fs'))
//               .fontWeight(FontWeight.Normal)
//               .fontColor($r('app.color.title_font_color'))
//               .opacity(Common.SUBTITLE_OPACITY)
//               .visibility(this.titleMarginTop === MIN_MARGIN_TOP ? Visibility.None : Visibility.Visible)
//           }
//           .margin({
//             top: `${this.titleMarginTop}vp`
//           })
//           .width(BaseCommon.FULL_PERCENT)
//
//           Scroll() {
//             Swiper() {
//               ForEach(BaseCommon.RANK_TITLE_LIST, (item: ResourceStr, index: number) => {
//                 HotListView({
//                   groupTitle: item,
//                   index: index
//                 })
//                   .margin({
//                     top: this.titleMarginTop === MIN_MARGIN_TOP ?
//                       $r('app.float.hot_list_view_min_mt') : $r('app.float.hot_list_view_max_mt')
//                   })
//                   .width(this.currentBreakpoint === Breakpoint.BREAKPOINT_SM ?
//                     BaseCommon.FULL_PERCENT : $r('app.float.zero'))
//                   .padding({
//                     left: new BreakpointType($r('app.float.window_padding_left_sm'),
//                       $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_lg')
//                     ).getValue(this.currentBreakpoint)
//                   })
//               }, (item: string) => JSON.stringify(item))
//             }
//             .displayCount(this.getDisplayCount())
//             .indicator(false)
//             .loop(true)
//             .nextMargin(new BreakpointType($r('app.float.swiper_next_margin_sm'), $r('app.float.swiper_next_margin_md'),
//               $r('app.float.swiper_next_margin_lg')).getValue(this.currentBreakpoint))
//             .height(BaseCommon.FULL_PERCENT)
//             .width(BaseCommon.FULL_PERCENT)
//             .onChange((index: number) => {
//               this.index = index;
//             })
//           }
//           .scrollBar(BarState.Off)
//           .onScrollFrameBegin((offset: number, state: ScrollState) => {
//             return { offsetRemain: this.calcMarginTop(offset) };
//           })
//           .layoutWeight(1)
//         }
//
//         Row() {
//           Image($r('app.media.ic_public_back'))
//             .width($r('app.float.back_icon_width'))
//             .aspectRatio(1)
//             .onClick(() => {
//               this.pageInfos.pop();
//             })
//
//           Image($r('app.media.ic_public_more'))
//             .width($r('app.float.more_icon_width'))
//             .aspectRatio(1)
//         }
//         .justifyContent(FlexAlign.SpaceBetween)
//         .padding({
//           top: $r('app.float.tool_line_pt'),
//           left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
//             $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
//           right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
//             $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
//         })
//         .width(BaseCommon.FULL_PERCENT)
//       }
//       .height(BaseCommon.FULL_PERCENT)
//       .width(BaseCommon.FULL_PERCENT)
//       .alignContent(Alignment.Top)
//       .backgroundColor($r('app.color.background_color'))
//     }
//     .height(BaseCommon.FULL_PERCENT)
//     .width(BaseCommon.FULL_PERCENT)
//   }
//
//   getDisplayCount() {
//     if (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM) {
//       return 1;
//     } else if (this.currentBreakpoint === Breakpoint.BREAKPOINT_MD) {
//       return 2;
//     } else {
//       return 3;
//     }
//   }
//
//   calcMarginTop(offset: number): number {
//     let realOffset: number = offset;
//     if (offset > 0 && this.titleMarginTop > MIN_MARGIN_TOP) {
//       let tmpOffset = this.titleMarginTop - offset;
//       let marginOffset: number = tmpOffset > MIN_MARGIN_TOP ? offset : this.titleMarginTop - MIN_MARGIN_TOP;
//       this.titleMarginTop -= marginOffset;
//       return 0;
//     }
//
//     if (offset < 0 && this.titleMarginTop < MAX_MARGIN_TOP) {
//       let tmpOffset = this.titleMarginTop + Math.abs(offset);
//       let marginOffset = tmpOffset > MAX_MARGIN_TOP ? MAX_MARGIN_TOP - this.titleMarginTop : Math.abs(offset);
//       this.titleMarginTop += marginOffset;
//       return 0;
//     }
//
//     return realOffset;
//   }
// }