import { CommonConstants } from '../common/constants/CommonConstants'
import { router } from '@kit.ArkUI';
import Home from '../view/Home';
import Setting from '../view/Setting';
import { BreakpointConstants } from '../common/constants/BreakpointConstants';
import { DailyShareIndex } from '../view/dailyshare/DailyShareIndex';
import { AIChatIndex } from '../view/aichat/AIChatIndex';
import { EQTestIndex } from '../view/eqtest/EQTestIndex';
import { UserInfoIndex } from '../view/userinfo/UserInfoIndex';
// import { deviceInfo } from '@kit.BasicServicesKit';
import lottie from '@ohos/lottie';
import { ResourceUtil } from '../common/utils/ResourceUtil';

@Entry
@Component
struct HomePage {

  // TODO 首次进入不显示？？？
  // TODO 滑动窗口
  // TODO 固定上部菜单栏

  // @State 用于声明组件的状态，currentBottomIndex 用于记录当前选中的标签栏索引。
  // @StorageLink 用于链接状态存储，currentBreakpoint 用于记录当前的屏幕断点。
  @State currentBottomIndex: number = CommonConstants.HOME_TAB_INDEX;
  @State firstEnter: number = 0;
/*  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;*/
  // 这些变量用于创建 Canvas 绘制上下文，每个标签栏选项都有一个对应的 Canvas。
  private renderingSettings1: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext1: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings1);
  private renderingSettings2: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings2);
  private renderingSettings3: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext3: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings3);
  private renderingSettings4: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext4: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings4);

  // 每个 tabBarOption 对象定义了一个标签栏选项，包含索引、文字、名称、路径和绘制上下文。
  private tabBarOption1: TabBarOption = {
    index: 0,
    text: $r('app.string.tab_bar_option_zero'),
    name: 'tab1',
    path: 'common/lottie/tabbar1.json',
    canvasRenderingContext: this.canvasRenderingContext1
  };
  private tabBarOption2: TabBarOption = {
    index: 1,
    text: $r('app.string.tab_bar_option_one'),
    name: 'tab2',
    path: 'common/lottie/tabbar2.json',
    canvasRenderingContext: this.canvasRenderingContext2
  };
  private tabBarOption3: TabBarOption = {
    index: 2,
    text: $r('app.string.tab_bar_option_two'),
    name: 'tab3',
    path: 'common/lottie/tabbar3.json',
    canvasRenderingContext: this.canvasRenderingContext3
  };
  private tabBarOption4: TabBarOption = {
    index: 3,
    text: $r('app.string.tab_bar_option_three'),
    name: 'tab4',
    path: 'common/lottie/tabbar4.json',
    canvasRenderingContext: this.canvasRenderingContext4
  };


  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.End
        // // barPosition 根据当前断点决定标签栏的位置。
        // barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End
      })
      {
        TabContent() {
          DailyShareIndex()
        }
        .tabBar(this.BottomTabBuilder(this.tabBarOption1))

        TabContent() {
          AIChatIndex();
        }
        .tabBar(this.BottomTabBuilder(this.tabBarOption2))

        TabContent() {
          EQTestIndex();
        }
        .tabBar(this.BottomTabBuilder(this.tabBarOption3))

        TabContent() {
          UserInfoIndex();
        }
        .tabBar(this.BottomTabBuilder(this.tabBarOption4))
      }
      // .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.bottom_tab_bar_width_lg') : CommonConstants.FULL_PERCENT)
      // .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? CommonConstants.FULL_PERCENT :
      //   ((deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
      //     CommonConstants.TAB_BAR_HEIGHT + CommonConstants.BOTTOM_RECT_HEIGHT)))
      .barBackgroundColor($r('app.color.tab_background_color'))
      .barHeight('10.5%')
      // .barMode(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarMode.Scrollable : BarMode.Fixed, { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
      // .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
        this.currentBottomIndex = targetIndex;
        this.lottieController();
      })
      .scrollable(false)
    }
  }

  // lottieController 方法用于控制 Lottie 动画的播放和停止，根据当前选中的标签栏选项播放对应的动画。
  lottieController(): void {
    if (this.currentBottomIndex === 0) {
      lottie.stop();
      lottie.play(this.tabBarOption1.name);
    }
    if (this.currentBottomIndex === 1) {
      lottie.stop();
      lottie.play(this.tabBarOption2.name);
    }
    if (this.currentBottomIndex === 2) {
      lottie.stop();
      lottie.play(this.tabBarOption3.name);
    }
    if (this.currentBottomIndex === 3) {
      lottie.stop();
      lottie.play(this.tabBarOption4.name);
    }
  }

  @Builder
  BottomTabBuilder(tabBarOption: TabBarOption) {
    Column() {
      Canvas(tabBarOption.canvasRenderingContext)
        .width($r('app.float.canvas_size'))
        .height($r('app.float.canvas_size'))
        .onReady(() => {
          lottie.loadAnimation({
            container: tabBarOption.canvasRenderingContext,
            renderer: 'canvas',
            loop: false,
            autoplay: false,
            name: tabBarOption.name,
            path: tabBarOption.path,
          });
          this.lottieController();
        })
      Text(tabBarOption.text)
        .fontSize($r('app.float.tab_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .fontColor(this.currentBottomIndex === tabBarOption.index ? $r('app.color.tab_sel_color') : ResourceUtil.getCommonBackgroundColor()[3])
        .margin({ top: $r('app.float.tab_top_margin') })
        .opacity(this.currentBottomIndex === tabBarOption.index ? CommonConstants.TEXT_OPACITY[0] : CommonConstants.TEXT_OPACITY[1])
    }
    .padding({
      top: $r('app.float.tab_top_margin'),
    })
    // .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.side_tab_bar_height') :
    // CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}

interface TabBarOption {
  index: number;
  text: ResourceStr;
  name: string;
  path: string;
  canvasRenderingContext: CanvasRenderingContext2D;
}