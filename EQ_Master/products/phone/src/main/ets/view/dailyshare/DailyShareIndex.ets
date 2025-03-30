import { CommonConstants } from '../../common/constants/CommonConstants'
import { PictureType } from '../../common/constants/PictureConstants'
import Logger from '../../common/utils/Logger'
import PromptUtil from '../../common/utils/PromptUtil'
import { DailyShare } from '../../server/dailyshare/DailyShareData'
import DailyShareServer from '../../server/dailyshare/DailyShareServer'
import ResponseResult from '../../server/ResponseResult'
import { TitleView } from '../TitleView'
import { Banner } from './Banner'
import { DailyShareShow } from './DailyShareShow'
import { text } from '@kit.ArkGraphics2D'
import { LengthMetrics } from '@kit.ArkUI'
import { CommonUtil } from './DailoyShareHead'

@Entry
@Component
export struct DailyShareIndex {
  @State colorArray: string[] =
    ['情商智力', '社交技能']
  @State currentIndex: number = 0
  @State animationDuration: number = 300
  @State indicatorLeftMargin: number = 0
  @State indicatorWidth: number = 0
  private tabsWidth: number = 0
  private textInfos: [number, number][] = []
  private isStartAnimateTo: boolean = false

  @State handlePopup:boolean = false

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#000000' : '#939393')
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .id(index.toString())
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.textInfos[index] = [newValue.globalPosition.x as number, newValue.width as number]
          if (!this.isStartAnimateTo && this.currentIndex === index && this.tabsWidth > 0) {
            this.setIndicatorAttr(this.textInfos[this.currentIndex][0], this.textInfos[this.currentIndex][1])
          }
        })
    }.width('100%')
  }

  aboutToAppear():void {
    for (let i = 0; i < this.colorArray.length; i++) {
      this.textInfos.push([0, 0]);
    }
  }

  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index
    if (index > 0 && (CommonUtil.getIsRTL() ? event.currentOffset < 0 : event.currentOffset > 0)) {
      nextIndex--
    } else if (index < this.textInfos.length - 1 &&
      (CommonUtil.getIsRTL() ? event.currentOffset > 0 : event.currentOffset < 0)) {
      nextIndex++
    }
    let indexInfo = this.textInfos[index]
    let nextIndexInfo = this.textInfos[nextIndex]
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth)
    let currentIndex = swipeRatio > 0.5 ? nextIndex : index // 页面滑动超过一半，tabBar切换到下一页。
    let currentLeft = indexInfo[0] + (nextIndexInfo[0] - indexInfo[0]) * swipeRatio
    let currentWidth = indexInfo[1] + (nextIndexInfo[1] - indexInfo[1]) * swipeRatio
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth }
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    this.isStartAnimateTo = true
    animateTo({
      duration: duration, // 动画时长
      curve: Curve.Linear, // 动画曲线
      iterations: 1, // 播放次数
      playMode: PlayMode.Normal, // 动画模式
      onFinish: () => {
        this.isStartAnimateTo = false
        console.info('play end')
      }
    }, () => {
      this.setIndicatorAttr(leftMargin, width)
    })
  }

  private setIndicatorAttr(leftMargin: number, width: number) {
    this.indicatorWidth = width
    if (CommonUtil.getIsRTL()) {
      this.indicatorLeftMargin = this.tabsWidth - leftMargin - width
    } else {
      this.indicatorLeftMargin = leftMargin
    }
  }

  // TODO 上拉刷新、下拉加载待实现
  // TODO 懒加载待实现

  build() {
    Column() {
      Row() {
        Text('       ')
          .margin({ top: '1%', bottom: '1.9%' })
        Text('每日分享')
          .margin({ top: '1%', bottom: '1.9%' })
          .fontSize('21fp')
          .fontColor(Color.Black)
          .fontWeight(560)
          .opacity(1)
        Text('详情') //可改成选项
          .fontSize('21fp')
          .fontColor(Color.Blue)
          .fontWeight(560)
          .margin({ top: '1%', bottom: '1.9%' })
          
          .onClick(()=>{
            this.handlePopup = !this.handlePopup
          })
          .bindPopup(this.handlePopup, {
          message: '介绍模块功能',
          onStateChange: (e)=> { // 返回当前的气泡状态
            if (!e.isVisible) {
              this.handlePopup = false
            }
          }
        })
      }
      .width(CommonConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceAround)
      // 底部灰色分割线
      .borderColor($r('app.color.hot_title_border_color'))
      .borderWidth({
        bottom: ($r('app.float.hot_title_border_width_normal'))
      })

      Stack({ alignContent: Alignment.TopStart }) {
        Tabs({ barPosition: BarPosition.Start }) {
          ForEach(this.colorArray, (item: string, index:number) => {
            TabContent() {
              Scroll() {
                Column() {
                  Banner()
                  Blank()
                    .height('2%')
                  DailyShareShow({ initType: PictureType.QUESTION}) //在DailyShareShow内部根据type加载initDailyShare
                  // Blank()
                  //   .height('1%')
                  DailyShareShow({ initType: PictureType.TIP})
                  // Blank()
                  //   .height('1%')
                  DailyShareShow({ initType: PictureType.STORY})
                  Blank()
                    .height('5%')
                }
              }
              .scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
            }.tabBar(this.tabBuilder(index, item))
          })
        }
        .onAreaChange((oldValue: Area, newValue: Area)=> {
          this.tabsWidth = newValue.width as number
          if (!this.isStartAnimateTo) {
            this.setIndicatorAttr(this.textInfos[this.currentIndex][0], this.textInfos[this.currentIndex][1])
          }
        })
        .barWidth('50%')
        .barHeight(56)
        .width('100%')
        .height('100%')
        .backgroundColor('#ffffff')
        .animationDuration(this.animationDuration)
        .onChange((index: number) => {
          this.currentIndex = index // 监听索引index的变化，实现页签内容的切换。
        })
        .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
          // 切换动画开始时触发该回调。下划线跟着页面一起滑动，同时宽度渐变。
          this.currentIndex = targetIndex
          this.startAnimateTo(this.animationDuration, this.textInfos[targetIndex][0], this.textInfos[targetIndex][1])
        })
        .onAnimationEnd((index: number, event: TabsAnimationEvent) => {
          // 切换动画结束时触发该回调。下划线动画停止。
          let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
          this.startAnimateTo(0, currentIndicatorInfo.left, currentIndicatorInfo.width)
        })
        .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
          // 在页面跟手滑动过程中，逐帧触发该回调。
          let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
          this.currentIndex = currentIndicatorInfo.index
          this.setIndicatorAttr(currentIndicatorInfo.left, currentIndicatorInfo.width)
        })

        Column()
          .height(2)
          .width(this.indicatorWidth)
          .margin({ start: LengthMetrics.vp(this.indicatorLeftMargin), top: LengthMetrics.vp(48) })
          .backgroundColor('#63c9ff')
      }.width('100%').height('100%')




    }
    .width(CommonConstants.FULL_WIDTH)
  }
}