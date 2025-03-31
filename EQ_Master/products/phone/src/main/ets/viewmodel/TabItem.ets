//定义tab每个小组件样式
export class TabItem {
  id: number;
  name: string | Resource;

  constructor(id: number, name: string | Resource) {
    this.id = id;
    this.name = name;
  }
}
//实例
export function initTabData(): TabItem[] {
  let tabDataArray: TabItem[] = [];
  TabItemData.forEach((item: TabItem) => {
    tabDataArray.push(new TabItem(item.id, item.name));
  })
  return tabDataArray;
}


const TabItemData: TabItem[] = [
  new TabItem(0, '工作'),
  new TabItem(1, '生活'),
  // new TabItem(2, $r('app.string.book')),
  // new TabItem(3, $r('app.string.novel')),
  // new TabItem(4, $r('app.string.caricature')),
  // new TabItem(5, $r('app.string.listen_book')),
  // new TabItem(6, $r('app.string.making_friends')),
  // new TabItem(7, $r('app.string.live_broadcast')),
  // new TabItem(8, $r('app.string.video'))
];
