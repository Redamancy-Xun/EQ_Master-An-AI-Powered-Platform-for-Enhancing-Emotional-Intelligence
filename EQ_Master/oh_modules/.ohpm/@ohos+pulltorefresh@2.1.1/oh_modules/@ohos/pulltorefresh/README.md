# PullToRefresh

## Introduction

PullToRefresh is an OpenHarmony UI component which allows users to pull down on a list or a page to trigger a refresh action and pull up to trigger a load action.
You can set built-in animation properties, customize animations, and use **lazyForEarch** data as the data source.

#### Effect

Built-in animation effect

![Refresh](gifs/Refresh_EN.gif)![Refresh](gifs/LoadMore_EN.gif)

## How to Install

```shell
ohpm install @ohos/pulltorefresh
```

## How to Use

### Quick Start

```typescript
// How to use the V1 decorator  
import { PullToRefresh } from '@ohos/pulltorefresh'

// Create a scroller instance.
private scroller: Scroller = new Scroller();
  
PullToRefresh({
  // (Mandatory) Data source of the list component.
  data: $data,
  // (Mandatory) List or grid component in the main layout.
  scroller: this.scroller,
  // (Mandatory) Custom list or grid view.
  customList: () => {
    // A UI method decorated by @Builder.
    this.getListView();
  },
  // (Optional) Callback used to handle the pull-down refresh action.
  onRefresh: () => {
    return new Promise<string>((resolve, reject) => {
      // Simulate a network request operation. When data is obtained 2 seconds after the network request, inform the component to refresh the list data.
      setTimeout(() => {
        resolve ('Refresh successful');
        this.data = [...this.dataNumbers];
      }, 2000);
    });
  },
  // (Optional) Callback used to handle the pull-up loading action.
  onLoadMore: () => {
    return new Promise<string>((resolve, reject) => {
      // Simulate a network request operation. When data is obtained 2 seconds after the network request, inform the component to update the list data.
      setTimeout(() => {
        resolve('');
        this.data.push ("Added items" + this.data.length);
      }, 2000);
    });
  },
  customLoad: null,
  customRefresh: null,
})
  
// How to use the V2 decorator  
import { PullToRefreshV2 } from '@ohos/pulltorefresh'

// Create a scroller instance.
private scroller: Scroller = new Scroller();

PullToRefreshV2({
  // (Optional) Data source of the list component.
  data: this.data,
  // (Mandatory) List or grid component in the main layout.
  scroller: this.scroller,
  // (Mandatory) Custom list or grid view.
  customList: () => {
    // A UI method decorated by @Builder.
    this.getListView();
  },
  // (Optional) Callback used to handle the pull-down refresh action.
  onRefresh: () => {
    return new Promise<string>((resolve, reject) => {
      // Simulate a network request operation. When data is obtained 2 seconds after the network request, inform the component to refresh the list data.
      setTimeout(() => {
        resolve ('Refresh successful');
        this.data = [...this.dataNumbers];
      }, 2000);
    });
  },
  // (Optional) Callback used to handle the pull-up loading action.
  onLoadMore: () => {
    return new Promise<string>((resolve, reject) => {
      // Simulate a network request operation. When data is obtained 2 seconds after the network request, inform the component to update the list data.
      setTimeout(() => {
        resolve('');
        this.data.push ("Added items" + this.data.length);
      }, 2000);
    });
  },
  customLoad: null,
  customRefresh: null,
})
```

For details about how to set properties and customize animations, see [Example entry](https://gitee.com/openharmony-sig/PullToRefresh/tree/master/entry/src/main/ets/pages).

### Constraints
- Only the **List**, **Scroll**, **Tabs**, **Grid**, and **WaterFlow** system container components are supported.
- The spring effect and shadow effect of the system container components cannot be set. The **edgeEffect** value must be **EdgeEffect.None**.

- The pull-up loading action cannot be automatically triggered when the page bottom is reached.

- The pull-up loading action cannot be triggered when the current screen is not fully occupied.

- The pull-down refresh action cannot be triggered by code.

- The callback used to return the gesture end indication is not supported when the pull-down refresh animation ends.


### Using LazyForEarch Data as Data Source
**LazyForEach** iterates over provided data sources and creates corresponding components during each iteration. When **LazyForEach** is used in a **Scroll** container, the framework creates components as required within the visible area of the **Scroll** container. When a component is out of the visible area, the framework destroys the component to release memory.

 **LazyForEach**

```typescript
LazyForEach(
    dataSource: IDataSource,             // Data source to iterate over.
    itemGenerator: (item: any, index?: number) => void,  // Create child components.
    keyGenerator?: (item: any, index?: number) => string // Create unique keys.
): void
```
**IDataSource**

```typescript
interface IDataSource {
    totalCount(): number; // Obtain the total number of data items.
    getData(index: number): Object; // Obtain the data item that matches the specified index.
    registerDataChangeListener(listener: DataChangeListener): void; // Register a data change listener.
    unregisterDataChangeListener(listener: DataChangeListener): void; // Unregister a data change listener.
}
```
**DataChangeListener**
```typescript
interface DataChangeListener {
    onDataReloaded(): void; // Called when data is reloaded.
    onDataAdded(index: number): void; // Called when data is added.
    onDataMoved(from: number, to: number): void; // Called when data is moved.
    onDataDeleted(index: number): void; // Called when data is deleted.
    onDataChanged(index: number): void; // Called when data is changed.
    onDataAdd(index: number): void; // Called to add data.
    onDataMove(from: number, to: number): void; // Called to move data.
    onDataDelete(index: number): void; // Called to delete data.
    onDataChange(index: number): void; // Called to change data.
}
```
For details, see [LazyForEach: Lazy Data Loading](https://docs.openharmony.cn/pages/v4.1/en/application-dev/quick-start/arkts-rendering-control-lazyforeach.md/).
## Available APIs

### PullToRefresh/PullToRefreshV2 Properties

| Name                |                                         Type                                        |          Description          | Default Value                        |
| :------------------|:----------------------------------------------------------------------------------|:---------------------| :---------------------------- |
| data                |                                     Object[] \|       undefined       | Data source of the list or grid component.        | undefined                      |
| scroller            |                                      Scroller                                      | Scroller object associated with the list or grid component.| undefined                      |
| customList          |                                `() => void   `                                 |  Custom main layout, with a list or grid component.  | undefined                      |
| refreshConfigurator |                             PullToRefreshConfigurator                              |        Component configuration.        | PullToRefreshConfigurator      |
| mWidth              |                                       Length                                       |          Container width.         | undefined (adaptive)             |
| mHeight             |                                       Length                                       |          Container height.         | undefined (adaptive)             |
| onRefresh           |                            `() => Promise<string>`                             |        Callback used to handle the pull-down refresh action.        | Finish the pull-down refresh animation after 1s and report "Refresh failed".|
| onLoadMore          |                            `() => Promise<string>`                             |       Callback used to handle the pull-up loading action.       | Finish the pull-up loading animation after 1s.             |
| customRefresh       |                                 `() => void `                                  |      Custom layout for the refresh animation.     | undefined                      |
| onAnimPullDown      |           ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         Callback to be invoked during the pull-down animation.        | undefined                      |
| onAnimRefreshing    |           ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         Callback to be invoked during the refreshing animation.        | undefined                      |
| customLoad          |                                  `() => void`                                  |      Custom layout of the pull-up loading animation.     | undefined                      |
| onAnimPullUp        | ```(value?: number, width?: number, height?: number) => void \|    undefined  ```     |         Callback to be invoked during the pull-up animation.        | undefined                      |
| onAnimLoading       |           ```(value?: number, width?: number, height?: number) => void \|      undefined  ```   |         Callback to be invoked during the loading animation.        | undefined                      |

### PullToRefreshConfigurator APIs

| API                      | Type                    |             Description            | Default Value           |
| :------------------------| :------------------------- |:--------------------------| :-------------- |
| setHasRefresh             | boolean                     |         Sets whether to enable pull-down refresh.        | true             |
| setHasLoadMore            | boolean                     |         Sets whether to enable pull-up loading.        | true             |
| setMaxTranslate           | number                      |         Sets the maximum distance that the component can be pulled up and down.        | 100              |
| setSensitivity            | number                      |          Sets the sensitivity of the Pull-down and pull-up actions.          | 0.7              |
| setListIsPlacement        | boolean                     |        Sets whether the list should return to its original position after the pull-up or pull-down action is complete.        | true             |
| setAnimDuration           | number                      |       Sets the duration of the animation for the action.      | 150              |
| setRefreshHeight          | number                      |           Sets the height of the refresh animation.          | 30               |
| setRefreshColor           | string                      |           Sets the color of the refresh animation area.          | '#999999'        |
| setRefreshBackgroundColor | ResourceColor               |         Sets the background color of the refresh animation area.         | 'rgba(0,0,0,0)'  |
| setRefreshTextColor       | ResourceColor               |      Sets the color of the text displayed during the refresh action.     | '#999999'        |
| setRefreshTextSize        | number, string, or resource|      Sets the size of the text displayed during the refresh action.     | 18               |
| setRefreshAnimDuration    | number                      | Sets the duration of the refresh animation, which is valid only when the refresh animation is customized.| 1000             |
| setRefreshCompleteTextHoldTime    | number                      | Sets the duration for which the "refresh complete" text is displayed after the refresh action is finished.| 1000             |
| setLoadImgHeight          | number                      |         Sets the height of the loading image used in the pull-up animation.        | 30               |
| setLoadBackgroundColor    | ResourceColor               |         Sets the background color of the loading animation area.         | 'rgba(0,0,0,0)'   |
| setLoadTextColor          | ResourceColor               |         Sets the color of the text displayed during the loading.         | '#999999'         |
| setLoadTextSize           | number, string, or resource|         Sets the size of the text displayed during the loading.         | 18                |
| setLoadTextPullUp1        | string                      |          Sets the text displayed during the first stage of the pull-up action.          | 'Refreshing…'  |
| setLoadTextPullUp2        | string                      |          Sets the text displayed during the second stage of the pull-up action.          | 'Release to refresh'        |
| setLoadTextLoading        | string                      |        Sets the text displayed during the loading.        | 'Loading...'|

## Constraints

This project has been verified in the following version:

DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release(5.0.0.66)

## How to Contribute

If you find any problem during the use, submit an  [Issue](https://gitee.com/openharmony-sig/PullToRefresh/issues) or a [PR](https://gitee.com/openharmony-sig/PullToRefresh/pulls) to us.

## License

This project is licensed under [Apache License 2.0](https://gitee.com/openharmony-sig/PullToRefresh/blob/master/LICENSE).
