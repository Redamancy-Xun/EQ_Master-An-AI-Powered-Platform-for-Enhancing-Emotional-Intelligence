import { hilog } from '@kit.PerformanceAnalysisKit';
import { TabItem ,initTabData} from '../../viewmodel/TabItem';
import { SelectLifePage } from './SelectLifePage';
import { SelectWorkPage } from './SelectWorkPage';

@Entry
@Component
export struct SelectPage {
  @State tabArray: Array<TabItem> = initTabData();
  @State currentIndex: number = 0;

  //构建函数，定义样式
  @Builder
  tabBuilder(index: number, item:TabItem) {
    Text(item.name)
      .fontColor(Color.Black)
      .fontSize(this.currentIndex === index ? 20 : 16)
      .fontWeight(this.currentIndex === index ? 600 : FontWeight.Normal)
      .lineHeight(22)
      .id(index.toString())
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        SelectWorkPage()
      }.tabBar(this.tabBuilder(0, this.tabArray[0]))
      TabContent() {
        SelectLifePage()
      }.tabBar(this.tabBuilder(1, this.tabArray[1]))

    }
    .barWidth('100%')
    .barHeight(52)
    .width('100%')
    .height('100%')
    .animationDuration(300)
    .onAnimationStart((index: number, targetIndex: number) => {
      hilog.info(0x0000, 'index', index.toString());
      this.currentIndex = targetIndex;
    })
  }
}

// .onClick(() => {
//   this.controller.changeIndex(tabIndex);
//   this.focusIndex = tabIndex;
// })
