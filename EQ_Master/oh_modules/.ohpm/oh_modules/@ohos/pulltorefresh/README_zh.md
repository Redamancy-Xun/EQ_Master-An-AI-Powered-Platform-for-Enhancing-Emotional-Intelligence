# PullToRefresh

## 简介

> PullToRefresh是一款OpenHarmony环境下可用的下拉刷新、上拉加载组件。
> 支持设置内置动画的各种属性，支持设置自定义动画，支持lazyForEarch的数据作为数据源。

#### 效果展示：

内置动画效果

![Refresh](gifs/Refresh.gif)![Refresh](gifs/LoadMore.gif)

## 下载安装

```shell
ohpm install @ohos/pulltorefresh
```

## 使用说明

### 快速使用

```typescript
// V1装饰器下的使用方式
import { PullToRefresh } from '@ohos/pulltorefresh'

// 需绑定列表或宫格组件
private scroller: Scroller = new Scroller();
  
PullToRefresh({
// 必传项，列表组件所绑定的数据
data: $data,
// 必传项，需绑定传入主体布局内的列表或宫格组件
scroller: this.scroller,
// 必传项，自定义主体布局，内部有列表或宫格组件
customList: () => {
  // 一个用@Builder修饰过的UI方法
  this.getListView();
},
// 可选项，下拉刷新回调
onRefresh: () => {
  return new Promise<string>((resolve, reject) => {
    // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
    setTimeout(() => {
      resolve('刷新成功');
      this.data = [...this.dataNumbers];
    }, 2000);
  });
},
// 可选项，上拉加载更多回调
onLoadMore: () => {
  return new Promise<string>((resolve, reject) => {
    // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
    setTimeout(() => {
      resolve('');
      this.data.push("增加的条目" + this.data.length);
    }, 2000);
  });
},
customLoad: null,
customRefresh: null,
})

// V2装饰器下的使用方式
import { PullToRefreshV2 } from '@ohos/pulltorefresh'

// 需绑定列表或宫格组件
private scroller: Scroller = new Scroller();

PullToRefreshV2({
   // 可选项，列表组件所绑定的数据
   data: this.data,
   // 必传项，需绑定传入主体布局内的列表或宫格组件
   scroller: this.scroller,
   // 必传项，自定义主体布局，内部有列表或宫格组件
   customList: () => {
      // 一个用@Builder修饰过的UI方法
      this.getListView();
   },
   // 可选项，下拉刷新回调
   onRefresh: () => {
      return new Promise<string>((resolve, reject) => {
         // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
         setTimeout(() => {
            resolve('刷新成功');
            this.data = [...this.dataNumbers];
         }, 2000);
      });
   },
   // 可选项，上拉加载更多回调
   onLoadMore: () => {
      return new Promise<string>((resolve, reject) => {
         // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
         setTimeout(() => {
            resolve('');
            this.data.push("增加的条目" + this.data.length);
         }, 2000);
      });
   },
   customLoad: null,
   customRefresh: null,
})
```

设置属性示例和设置自定义动画示例请看[示例entry](https://gitee.com/openharmony-sig/PullToRefresh/tree/master/entry/src/main/ets/pages)

### 使用限制
1、目前只支持List、Scroll、Tabs、Grid和WaterFlow系统容器组件；

2、暂不支持设置系统容器组件的弹簧效果和阴影效果，使用时需要将系统组件edgeEffect属性的值设置为(EdgeEffect.None)；

3、暂不支持页面触底时自动触发上拉加载功能；

4、暂不支持在页面数据不满一屏时触发上拉加载功能；

5、暂不支持通过代码的方式去触发下拉刷新功能；

6、暂不支持在下拉刷新动画结束时提供手势结束的回调；

### 支持lazyForEarch的数据作为数据源
   LazyForEach从提供的数据源中按需迭代数据，并在每次迭代过程中创建相应的组件。当LazyForEach在滚动容器中使用了，框架会根据滚动容器可视区域按需创建组件，当组件滑出可视区域外时，框架会进行组件销毁回收以降低内存占用
   **接口描述：**
```typescript
LazyForEach(
    dataSource: IDataSource,             // 需要进行数据迭代的数据源
    itemGenerator: (item: any, index?: number) => void,  // 子组件生成函数
    keyGenerator?: (item: any, index?: number) => string // 键值生成函数
): void
```
**IDataSource类型说明**
```typescript
interface IDataSource {
    totalCount(): number; // 获得数据总数
    getData(index: number): Object; // 获取索引值对应的数据
    registerDataChangeListener(listener: DataChangeListener): void; // 注册数据改变的监听器
    unregisterDataChangeListener(listener: DataChangeListener): void; // 注销数据改变的监听器
}
```
**DataChangeListener类型说明**
```typescript
interface DataChangeListener {
    onDataReloaded(): void; // 重新加载数据时调用
    onDataAdded(index: number): void; // 添加数据时调用
    onDataMoved(from: number, to: number): void; // 数据移动起始位置与数据移动目标位置交换时调用
    onDataDeleted(index: number): void; // 删除数据时调用
    onDataChanged(index: number): void; // 改变数据时调用
    onDataAdd(index: number): void; // 添加数据时调用
    onDataMove(from: number, to: number): void; // 数据移动起始位置与数据移动目标位置交换时调用
    onDataDelete(index: number): void; // 删除数据时调用
    onDataChange(index: number): void; // 改变数据时调用
}
```
具体使用请看 openharmony：[LazyForEach：数据懒加载](https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/quick-start/arkts-rendering-control-lazyforeach.md/)
## 属性（接口）说明

### PullToRefresh/PullToRefreshV2组件属性

| 属性                 |                                         类型                                         |          释义           | 默认值                         |
| :------------------:|:----------------------------------------------------------------------------------:|:---------------------:| :----------------------------: |
| data                |                                     Object[] \|       undefined       | 列表或宫格组件所绑定的数据         | undefined                      |
| scroller            |                                      Scroller                                      | 列表或宫格组件所绑定的Scroller对象 | undefined                      |
| customList          |                                ```() => void   ```                                 |  自定义主体布局，内部有列表或宫格组件   | undefined                      |
| refreshConfigurator |                             PullToRefreshConfigurator                              |        组件属性配置         | PullToRefreshConfigurator      |
| mWidth              |                                       Length                                       |          容器宽          | undefined（自适应）              |
| mHeight             |                                       Length                                       |          容器高          | undefined（自适应）              |
| onRefresh           |                            ```() => Promise<string>```                             |        下拉刷新回调         | 1秒后结束下拉刷新动画并提示“刷新失败” |
| onLoadMore          |                            ```() => Promise<string>```                             |       上拉加载更多回调        | 1秒后结束上拉加载动画              |
| customRefresh       |                                 ```() => void ```                                  |      自定义下拉刷新动画布局      | undefined                      |
| onAnimPullDown      |           ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         下拉中回调         | undefined                      |
| onAnimRefreshing    |           ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         刷新中回调         | undefined                      |
| customLoad          |                                  ```() => void```                                  |      自定义上拉加载动画布局      | undefined                      |
| onAnimPullUp        | ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         上拉中回调         | undefined                      |
| onAnimLoading       |           ```(value?: number, width?: number, height?: number) => void \|      undefined  ```   |         加载中回调         | undefined                      |

### PullToRefreshConfigurator类接口

| 接口                       | 参数类型                     |             释义             | 默认值            |
| :------------------------:| :-------------------------: |:--------------------------:| :--------------: |
| setHasRefresh             | boolean                     |         是否具有下拉刷新功能         | true             |
| setHasLoadMore            | boolean                     |         是否具有上拉加载功能         | true             |
| setMaxTranslate           | number                      |         可下拉上拉的最大距离         | 100              |
| setSensitivity            | number                      |          下拉上拉灵敏度           | 0.7              |
| setListIsPlacement        | boolean                     |        滑动结束后列表是否归位         | true             |
| setAnimDuration           | number                      |       滑动结束后，回弹动画执行时间       | 150              |
| setRefreshHeight          | number                      |           下拉动画高度           | 30               |
| setRefreshColor           | string                      |           下拉动画颜色           | '#999999'        |
| setRefreshBackgroundColor | ResourceColor               |         下拉动画区域背景色          | 'rgba(0,0,0,0)'  |
| setRefreshTextColor       | ResourceColor               |      下拉加载完毕后提示文本的字体颜色      | '#999999'        |
| setRefreshTextSize        | number 或 string 或 Resource |      下拉加载完毕后提示文本的字体大小      | 18               |
| setRefreshAnimDuration    | number                      | 下拉动画执行一次的时间，仅在自定义下拉刷新动画时有效 | 1000             |
| setRefreshCompleteTextHoldTime    | number                      | 下拉刷新完毕后, 刷新成功文本停留的时间 | 1000             |
| setLoadImgHeight          | number                      |         上拉动画中图片的高度         | 30               |
| setLoadBackgroundColor    | ResourceColor               |         上拉动画区域背景色          | 'rgba(0,0,0,0)'   |
| setLoadTextColor          | ResourceColor               |         上拉文本的字体颜色          | '#999999'         |
| setLoadTextSize           | number 或 string 或 Resource |         上拉文本的字体大小          | 18                |
| setLoadTextPullUp1        | string                      |          上拉1阶段文本           | '正在上拉刷新...'   |
| setLoadTextPullUp2        | string                      |          上拉2阶段文本           | '放开刷新'         |
| setLoadTextLoading        | string                      |        上拉加载更多中时的文本         | '正在玩命加载中...' |

## 约束与限制

在下述版本验证通过：
- `DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release(5.0.0.66)`

## 贡献代码

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/openharmony-sig/PullToRefresh/issues)给组件，当然，也非常欢迎发 [PR](https://gitee.com/openharmony-sig/PullToRefresh/pulls) 共建。

## 开源协议

本项目基于 [Apache License 2.0](https://gitee.com/openharmony-sig/PullToRefresh/blob/master/LICENSE) ，请自由地享受和参与开源。
