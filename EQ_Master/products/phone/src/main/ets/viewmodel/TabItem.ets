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
];
