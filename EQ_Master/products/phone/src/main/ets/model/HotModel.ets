

export class HotItem {
  index: number = 0
  dailyShareId: string = ''
  icon: Resource | undefined = undefined
  title: ResourceStr = ''
  content: ResourceStr = ''
  stateIcon: ResourceStr = ''
  clickCount: number = 0
  upDownIcon: ResourceStr = ''
}
//       index: 15,
//       icon: $r('app.media.ic_rank_item_5'),
//       title: $r('app.string.title_5'),
//       content: $r('app.string.content_18'),
//       stateIcon: $r('app.media.ic_state_fire'),
//       clickCount: 257,
//       upDownIcon: $r('app.media.ic_up')