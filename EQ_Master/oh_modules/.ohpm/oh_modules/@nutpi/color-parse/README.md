# color-parse

A JSON with color names and its values. Based on http://dev.w3.org/csswg/css-color/#named-colors.

## 一、下载安装

```
ohpm install @nutpi/color-parse
```

OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.md)

## 二、使用

```js
import parse from '@nutpi/color-parse';
parse('hsla(12 10% 50% / .3)')
// { space: 'hsl', values: [12, 10, 50], alpha: 0.3 }
```

## Parsed strings



-  Color keywords: `red`, `green` etc., see [color-name](https://atomgit.com/nutpi_tpc/color-name)
-  `#RGB[A]`
-  `#RRGGBB[AA]`
-  `rgb[a](R, G, B[, A])`
-  `rgb(R G B[ / A])`
-  `hsl[a](H, S, L[, A])`, inc. [named hues](http://dev.w3.org/csswg/css-color/#simple-hues)
-  `hsl(H S L [ / A])`
-  `hwb(H, W, B)`
-  `cmyk(C, M, Y, K)`
-  `xyz(X, Y, Z)`
-  `luv(L, U, V)`
-  `luv(L U V[ / A])`
-  `lab(L, A, B)`
-  `lab(L a b[ / A])` - see [limits](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/lab)
-  `lch(L, C, H)`
-  `lch(L C H[ / A])` - see [limits](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/lch)
-  `oklab(L a b[ / A])` - see [limits](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/oklab)
-  `oklch(L C H[ / A])` - see [limits](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/oklch)
-  `color(space c1 c2 c3[ / A])`
-  `R:10 G:20 B:30`
-  `(R10 / G20 / B30)`
-  `C100/M80/Y0/K35`
-  `[10, 20, 20]` as RGB
-  `10,20,20` as RGB
-  `0x00ff00`, `0x0000ff` numbers as RGB
- 

## 三、开源协议

本项目基于 [MIT](LICENSE) ，请自由地享受和参与开源。感谢坚果派的小伙伴做出的努力。



## 四、运行环境

DevEco Studio NEXT Developer Beta1
Build Version: 5.0.3.401,

适用于API：12及以上，在真机Mate60测试ok。



## 五、关于坚果派

团队介绍：坚果派由坚果等人创建，团队拥有12个华为HDE，以及若干其他领域的三十余位万粉博主运营。专注于分享HarmonyOS/OpenHarmony，ArkUI-X，元服务，仓颉，团队成员聚集在北京，上海，南京，深圳，广州，宁夏等地，目前已开发鸿蒙原生应用，三方库40+。



