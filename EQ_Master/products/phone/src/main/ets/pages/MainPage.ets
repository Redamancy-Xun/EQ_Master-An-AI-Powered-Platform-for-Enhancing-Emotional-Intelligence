/**
 * Main page.
 */
import { CommonConstants } from '../common/constants/CommonConstants'
import { router } from '@kit.ArkUI';
import Home from '../view/Home';
import Setting from '../view/Setting';

@Entry
@Component
struct MainPage {
  @State index: number = CommonConstants.HOME_TAB_INDEX;
  @StorageLink('userLogin') userLogin: boolean = false;
  private tabsController: TabsController = new TabsController();

  @Builder
  baseTab(title: Resource, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.index === targetIndex ? selectedImg : normalImg)
        .width($r('app.float.main_base_size'))
        .height($r('app.float.main_base_size'))
      Text(title)
        .margin({ top: $r('app.float.main_base_top') })
        .fontSize($r('app.float.main_tab_fontSize'))
        .fontColor(this.index === targetIndex ? $r('app.color.main_selected') : $r('app.color.main_normal'))
    }
    .margin({ top: $r('app.float.main_base_margin') })
    .height($r('app.float.main_bar_height'))
    .width(CommonConstants.FULL_PARENT)
    .onClick(() => {
      this.index = targetIndex;
      this.tabsController.changeIndex(this.index);
    })
  }

  @Builder
  tabTitles(title: Resource) {
    Text(title)
      .fontWeight(FontWeight.Medium)
      .fontSize($r('app.float.title_text_size'))
      .margin({ top: $r('app.float.main_titles_margin') })
      .padding({ left: $r('app.float.main_titles_padding') })
  }

  onPageShow(): void {
    if (!this.userLogin) {
      router.replaceUrl({
        url: 'pages/LoginPage'
      })
    }
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        this.tabTitles($r('app.string.main_tab_home'))
        Home()
      }
      .padding({
        left: $r('app.float.main_padding'),
        right: $r('app.float.main_padding')
      })
      .backgroundColor($r('app.color.main_background'))
      .tabBar(this.baseTab($r('app.string.home_title'), CommonConstants.HOME_TAB_INDEX,
        $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')))

      TabContent() {
        this.tabTitles($r('app.string.main_tab_mine'))
        Setting()
      }
      .padding({
        left: $r('app.float.main_padding'),
        right: $r('app.float.main_padding')
      })
      .backgroundColor($r('app.color.main_background'))
      .tabBar(this.baseTab($r('app.string.mine_title'), CommonConstants.MINE_TAB_INDEX,
        $r('app.media.ic_mine_selected'), $r('app.media.ic_mine_normal')))
    }
    .width(CommonConstants.FULL_PARENT)
    .backgroundColor(Color.White)
    .barHeight($r('app.float.main_bar_height'))
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.index = index
    })
  }
}