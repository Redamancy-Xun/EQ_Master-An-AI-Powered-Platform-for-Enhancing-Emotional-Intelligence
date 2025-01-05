## 2.1.1

1、2.1.1 is released

## 2.1.1-rc.1

1、Addressed an issue where V1 and V2 decorators were incompatible with PullToRefresh
2、Added the PullToRefreshV2 API for the component

## 2.1.1-rc.0

1、添加中英文README.md修改以及demo国际化处理
2、loadTextPullUp1、loadTextPullUp2、loadTextLoading、loadText等接口类型修改为 "ResourceStr"

## 2.1.0

1、发布2.1.0正式版本

## 2.1.0-rc.1

1、新增设置下拉刷新成功后刷新成功文本的停留时间接口setRefreshCompleteTextHoldTime

## 2.1.0-rc.0

1、新版装饰器语法整改

## 2.0.6

1、发布2.0.6正式版本

## 2.0.6-rc.0

1、修复自定义下拉刷新和自定义上拉加载在刷新完成之后页面残留的问题

## 2.0.5

1、修复页面滑动到顶部时，偶现无法下拉的问题
2、修复下拉刷新回滑时list组件底层跟着滑动的问题

## 2.0.4

1.ArkTS的语法整改。

## 2.0.3

1.修复组件在低版本镜像出现下拉刷新闪退问题。
2.适配DevEco Studio: 4.0 Canary2(4.0.3.300)
  适配SDK: API10 (4.0.8.6)

## 2.0.2

1.修复在轻微上拉的过程中，可能会出现直接滑动到底部的问题。

## 2.0.1

1.修复上拉加载后上划到顶部无法触发下拉加载的问题。
2.修复在TabContent组件中使用PullToRefresh，Tab无法左右滑动的问题。
3.修复在PullToRefresh顶部的时候，上拉手势误触发下拉刷新的回弹动画效果问题。

## 2.0.0

1.包管理工具由npm切换为ohpm。
2.适配DevEco Studio: 3.1Beta2(3.1.0.400)。
3.适配SDK: API9 Release(3.2.11.9)。

## 1.0.2

1.适配DevEco Studio 3.1Beta1及以上版本。

2.适配OpenHarmony SDK API version 9及以上版本。

3.组件的默认宽高适配为跟随父组件大小。

## 1.0.1

1.新增设置下拉动画执行时间的接口setRefreshAnimDuration

2.新增data属性，当页面中其他地方对列表数据进行修改时，组件内的列表组件会同步刷新UI

## 1.0.0
1.支持下拉刷新

2.支持上拉加载更多

3.支持设置内置动画的各种属性

4.支持自定义动画