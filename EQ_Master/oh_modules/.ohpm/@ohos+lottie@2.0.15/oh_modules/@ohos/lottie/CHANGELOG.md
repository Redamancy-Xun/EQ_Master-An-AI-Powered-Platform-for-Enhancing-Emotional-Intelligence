## v2.0.15
    fix: Fix the issue where animations are automatically destroyed when their state is not visible in a specific scene
    fix: Fix the issue of failed dynamic modification of multiple keyframe colors in animation

## v2.0.15-rc.1
    fix: Optimized and solved the problem of keyframe colors not taking effect in dynamic replacement animations
    fix: Fixed the issue of ineffective transparency settings for dynamic gradient colors in animations
    fix: Fix the issue of incorrect text display position in animation

## v2.0.15-rc.0
    fix: Fixed the issue where one or more animations were destroyed during simultaneous loading and playback, resulting in a low probability of crashes in the application
    feature: Support specifying replacement animation images
    fix: Fix the issue of abnormal animation font playback and animation effect size
    fix: Fix the problem of reading errors in sandbox image resources caused by insufficient read permissions or missing files

## v2.0.14
    Release version 2.0.14

## v2.0.14-rc.2
    fix: Fix the issue of reading the image_stource property incorrectly when the image data is incorrect
    fix: Modify and clear cache interface, clearing all/individual caches using the same interface

## v2.0.14-rc.1
    feature:When the animation is completely invisible, the current animation will automatically pause and stop sending drawing instructions to optimize performance and reduce power consumption

## v2.0.14-rc.0
    feature:支持清除全部缓存, 清除当前动画缓存
    feature:支持判断动画是否为网络播放
    feature:优化animator的使用方式，使用displaySync替代animator机制
    fix: 修复使用animationData方式加载播放网络资源图片失败的问题

## v2.0.13
    发布2.0.13正式版

## v2.0.13-rc.0
    fix: 修复json动画资源文件缺少e属性导致动画图片加载不出来的问题
    fix: 优化加载网络资源代码结构

## v2.0.12
    发布2.0.12正式版

## v2.0.12-rc.3
    fix: 修复在自动播放状态下，加载动画第一帧重复播放的问题

## v2.0.12-rc.2
    fix: 修复使用animateItem.destroy销毁方式，导致底层animator没有停止而一直在刷帧的问题
    fix: 修复动画暂停重新播放后，帧率使用默认帧率播放的问题

## v2.0.12-rc.1
    fix: 修复网络动画资源图片下载失败和字体没显示问题

## v2.0.12-rc.0
    fix: 修复部分含字体动画播放显示不全的问题

## v2.0.11
    发布2.0.11正式版

## v2.0.11-rc.7
    feature:支持读取指定路径下的图片资源
    fix: 修复加载多个zip资源导致加载异常
    fix: 修复频繁调用goToAndPlay()方法导致动画概率性出现播放不正常的问题

## v2.0.11-rc.6
    fix: 修复lottie 网络资源下载异常处理
    fix: 修复lottie 网络资源下载通知显示下载进度
    fix: 修复lottie动态修改动画颜色时蒙版图层不需要改动的问题

## v2.0.11-rc.5
    fix: 修复读取错误网络资源链接导致动画加载崩溃的问题

## v2.0.11-rc.4
    fix: 修复动画执行pause时，底层animator没有停止的问题
    fix：修复特殊场景下时间戳跳变引起时间差为负，导致动画播放跳到开始帧并完成播放的问题
    fix：修复下载的zip资源中带有文件夹导致动画加载失败

## v2.0.11-rc.3
    fix: 修复读取缓存资源，加载zip动画闪退的问题

## v2.0.11-rc.2
    fix: 修复动画被销毁时，重新设置当前存活animation的最高帧率
    feature:支持加载网络资源和通过URI路径方式加载动画

## v2.0.11-rc.1
    fix: 修复lottie跳帧不渲染的问题

## v2.0.11-rc.0
    fix: 修复图片资源默认使用图片自身宽高问题

## v2.0.10
    feature:新增支持设置animator的刷帧率功能
    fix: 修复无法触发'config_ready'、'data_ready'、'error'、'data_failed'监听事件问题
    fix: 使用saveLayer和restoreLayer方案替代原来的方式实现动画蒙版动效，优化动画性能
    feature:新增动画支持设置填充模式：Fill,Top,Cover,Bottom,Contain
    fix: 修复动画圆圈的虚线无法展现实际动画效果的问题
    fix: 修复图形变形没恢复导致画布重绘有残留图像的问题
    fix: 修复动画json资源文件含有音频和正则表达式内容，动画加载播放的失败问题
    fix: 修复加载多个动画，在特定场景下销毁个别正在播放的动画时animator没停止的问题
    fix: 修复在特殊情况下动画暂停再恢复，画面内容不连贯问题
    fix: 修复动画json有依赖图片资源不存在时，动画也可以加载播放的问题

## v2.0.10-rc.4
    feature:新增支持设置animator的刷帧率功能

## v2.0.10-rc.3
    fix: 修复无法触发'config_ready'、'data_ready'、'error'、'data_failed'监听事件问题
    fix: 使用saveLayer和restoreLayer方案替代原来的方式实现动画蒙版动效，优化动画性能

## v2.0.10-rc.2
    feature:新增动画支持设置填充模式：Fill,Top,Cover,Bottom,Contain
    fix: 修复动画圆圈的虚线无法展现实际动画效果的问题
    fix: 修复图形变形没恢复导致画布重绘有残留图像的问题

## v2.0.10-rc.1
    fix: 修复动画json资源文件含有音频和正则表达式内容，动画加载播放的失败问题
    fix: 修复加载多个动画，在特定场景下销毁个别正在播放的动画时animator没停止的问题

## v2.0.10-rc.0
    fix: 修复在特殊情况下动画暂停再恢复，画面内容不连贯问题
    fix: 修复动画json有依赖图片资源不存在时，动画也可以加载播放的问题

## v2.0.9
    fix: 新增支持动画mask相减蒙版模式特性
    fix: 修复动画播放在折叠屏设备上出现残影的问题

## v2.0.9-rc.0
    fix: 修复动画json文件里缺少e属性值导致外部资源图片加载失败的问题

## v2.0.8
    fix: 添加传入应用包名接口，用于日志打印区分不同模块调用启动animator线程，packageName可以不传
    fix: 更改animator的使用方式，适配lottie在插件模块下可以播放动画

## v2.0.7
    feature:新增支持读取沙箱路径下的图片资源
    fix: 为了适配HSP场景，loadAnimation接口新增当前场景上下文context可选参数传入，在HSP场景下需要传正确的context，非HSP场景不影响，context可以不传

## v2.0.7-rc.0
    feature:新增支持更改动画颜色的透明值和关键帧渐变色颜色特性

## v2.0.6
    feature:新增支持Canvas渲染动画的高斯模糊动效特性
    fix: piexlmap改成不可编辑状态，优化图形图像端读取速度

## v2.0.5
    fix: 优化性能，释放pixel_map，防止内存泄漏

## v2.0.5-rc.0
    fix: 修复lottie的registeredAnimations[i].animation空指针报错问题
    fix: 修正替换play函数为gotoFrame,防止play方法创建Animator对象，导致修改颜色后刷帧问题

## v2.0.4
    fix: 修复lottie播放mask动画多次调用getPixelMap方法，导致动画播放掉帧的问题
    fix: 适配ArkTs语法

## v2.0.3
    fix: 修复lottie不同版本在同一个界面启动，导致动画播放失败的问题
    fix: 修复动画销毁，重新刷新界面导致应用的崩溃问题

## v2.0.2
    feature:新增支持Canvas渲染中mask部分特性
            支持渲染本地图片，包含base64编码和文件路径方式
    fix: 修正圆形动画加载小球不重叠
    fix: 修正动画全部播放完后，Animator也要停止刷帧
    updated: 适配DevEco Studio: 4.0 Canary2(4.0.3.312)
             适配SDK: API10 (4.0.9.3)

## v2.0.1
    feature:新增动画动态渲染颜色能力
    fix: 修正License文件版权
    fix: 添加Array.apply()函数的参数检验，如果长度为undefined时，设置长度为0
    updated: 适配DevEco Studio: 4.0 Canary1(4.0.0.112)
             适配SDK: API10 (4.0.7.2)
    updated: 修改Library目录结构根目录名称

## v2.0.0
    feature: 动画加载代码解耦
    updated: 包管理工具由npm切换为ohpm
             适配DevEco Studio: 3.1 Beta2(3.1.0.400)
             适配SDK: API9 Release(3.2.11.9)

## v1.1.2
    fix: 未设置动画数据就直接加载动画，销毁动画时，导致的空指针异常
    fix: 修正根据路径加载不到动画数据时的处理方式，不进行构建动画配置
    fix: 删除动画加载限制，重复加载动画前需手动销毁上一个已加载动画
    fix: 补充readme文件内Lottie组件使用注意事项
         loadAnimation使用时须在页面加载完成之后，例如Canvas.onReady()生命周期
         loadAnimation加载动画使用path参数设置时，需要注意path参数只支持entry/src/main/ets文件夹下的相对路径，不支持跨包设置。
         同一Canvas组件加载多次/不同动画资源，需要手动销毁动画(lottie.destroy()/animationItem.destroy())，之后才可再次加载其他动画资源。

## v1.1.1
    feature:补充svg渲染能力
    适配原库5.10.0版本
不支持特性：
* 不支持SVG渲染中filter效果
* 不支持SVG渲染中mask部分特性
* 不支持渲染本地图片及网络图片资源

## v1.1.0
    updated: 名称由lottieETS修改为lottie
    updated: 旧的包@ohos/lottieETS已不再维护，请使用新包@ohos/lottie
    fix:修复多次在同一画布上加载动画，导致动画重叠的问题

不支持特性：
* 不支持SVG、HTML渲染方式
* 不支持组件控制动画显示、隐藏、resize
* 不支持注册动画
* 不支持查找动画
* 不支持更新动画数据
* 不支持部分效果
* 不支持含有表达式的动画


## v1.0.3
    fix:修复销毁动画时未清空画布的bug
    fix:添加对通过路径获取动画文件json数据的非空校验，如果未获取到将抛出异常进行提示


## v1.0.2
    适配API9 Stage 模型


## v1.0.1
    升级IDE到3.0.0.900，使项目能在该环境下运行


## v1.0.0
    适配兼容OpenHarmony系统，完成相关功能，具体如下：
* 动画播放、暂停、停止、切换暂停、跳到某一时刻并停止、跳到某一时刻并播放等动画基础功能。
* 播放指定片段、重置动画、设置播放速度、设置播放方向、添加监听状态、获取动画时长等扩展功能。
* canvas渲染。



### 对源库改动如下：
* 删除html渲染。
* 删除svg渲染，等待后续迭代。


