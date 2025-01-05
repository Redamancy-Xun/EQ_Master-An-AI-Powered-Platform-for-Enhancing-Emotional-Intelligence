export interface HotItemInterface {
  index: number;
  dailyShareId: string;
  icon: Resource | undefined;
  title: ResourceStr;
  content: ResourceStr;
  stateIcon: ResourceStr;
  clickCount: number;
  upDownIcon: ResourceStr;
}
//
// export const HOST_LIST_ARRAY: Array<HotItemInterface[]> = [
//   [
//     {
//       index: 1,
//       icon: $r('app.media.ic_today_rank_1'),
//       title: $r('app.string.title_1'),
//       content: $r('app.string.content_14'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 666,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 2,
//       icon: $r('app.media.ic_today_rank_2'),
//       title: $r('app.string.title_2'),
//       content: $r('app.string.content_15'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 651,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 3,
//       icon: $r('app.media.ic_today_rank_3'),
//       title: $r('app.string.title_3'),
//       content: $r('app.string.content_16'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 576,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 4,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 556,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 5,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 532,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 6,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 501,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 7,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 489,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 8,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 473,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 9,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 421,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 10,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 389,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 11,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 365,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 12,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 349,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 13,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 311,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 14,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 278,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')
//     }
//   ],
//   [
//     {
//       index: 1,
//       icon: $r('app.media.ic_news_rank_1'),
//       title: $r('app.string.title_9'),
//       content: $r('app.string.content_22'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 666,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 2,
//       icon: $r('app.media.ic_news_rank_2'),
//       title: $r('app.string.title_10'),
//       content: $r('app.string.content_23'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 651,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 3,
//       icon: $r('app.media.ic_news_rank_3'),
//       title: $r('app.string.title_11'),
//       content: $r('app.string.content_24'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 576,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 4,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 556,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 5,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 532,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 6,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 501,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 7,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 489,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 8,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 473,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 9,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 421,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 10,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 389,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 11,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 365,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 12,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 349,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 13,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 311,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 14,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 278,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')
//     }
//   ],
//   [
//     {
//       index: 1,
//       icon: $r('app.media.ic_city_rank_1'),
//       title: $r('app.string.title_12'),
//       content: $r('app.string.content_25'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 666,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 2,
//       icon: $r('app.media.ic_city_rank_2'),
//       title: $r('app.string.title_13'),
//       content: $r('app.string.content_26'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 651,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 3,
//       icon: $r('app.media.ic_city_rank_3'),
//       title: $r('app.string.title_14'),
//       content: $r('app.string.content_27'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 576,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 4,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 556,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 5,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 532,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 6,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 501,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 7,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 489,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 8,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 473,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 9,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 421,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 10,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 389,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 11,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 365,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 12,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 349,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 13,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 311,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 14,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 278,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')
//     }
//   ],
//   [
//     {
//       index: 1,
//       icon: $r('app.media.ic_fun_rank_1'),
//       title: $r('app.string.title_15'),
//       content: $r('app.string.content_28'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 666,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 2,
//       icon: $r('app.media.ic_fun_rank_2'),
//       title: $r('app.string.title_16'),
//       content: $r('app.string.content_29'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 651,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 3,
//       icon: $r('app.media.ic_fun_rank_3'),
//       title: $r('app.string.title_17'),
//       content: $r('app.string.content_30'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 576,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 4,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 556,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 5,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 532,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 6,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 501,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 7,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 489,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 8,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 473,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 9,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 421,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 10,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 389,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 11,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 365,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 12,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 349,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 13,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 311,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 14,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 278,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')
//     }
//   ],
//   [
//     {
//       index: 1,
//       icon: $r('app.media.ic_food_rank_1'),
//       title: $r('app.string.title_18'),
//       content: $r('app.string.content_31'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 666,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 2,
//       icon: $r('app.media.ic_food_rank_2'),
//       title: $r('app.string.title_19'),
//       content: $r('app.string.content_32'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 651,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 3,
//       icon: $r('app.media.ic_food_rank_3'),
//       title: $r('app.string.title_20'),
//       content: $r('app.string.content_33'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 576,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 4,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 556,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 5,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 532,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 6,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 501,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 7,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 489,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 8,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 473,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 9,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 421,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 10,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 389,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 11,
//       icon: $r('app.media.ic_rank_item_1'),
//       title: $r('app.string.title_6'),
//       content: $r('app.string.content_19'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 365,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 12,
//       icon: $r('app.media.ic_rank_item_2'),
//       title: $r('app.string.title_7'),
//       content: $r('app.string.content_20'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 349,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 13,
//       icon: $r('app.media.ic_rank_item_3'),
//       title: $r('app.string.title_8'),
//       content: $r('app.string.content_21'),
//       stateIcon: $r('app.media.ic_state_favor'),
//       clickCount: 311,
//       upDownIcon: $r('app.media.ic_up')
//     },
//     {
//       index: 14,
//       icon: $r('app.media.ic_rank_item_4'),
//       title: $r('app.string.title_4'),
//       content: $r('app.string.content_17'),
//       stateIcon: $r('app.media.ic_state_new'),
//       clickCount: 278,
//       upDownIcon: $r('app.media.ic_down')
//     },
//     {
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')
//     }
//   ]
// ]