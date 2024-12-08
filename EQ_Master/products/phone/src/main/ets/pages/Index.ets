import parse from '@nutpi/color-parse';

@Entry
@Component
struct Index {

  build() {
    Column() {
      Row() {
        Text("修改个人信息")
          .width('100%')
          .fontSize(24)
          .fontColor(parse('rgba(255, 255, 255, 1)').space)
          .textAlign(TextAlign.Start)
      }
      Text("分享一下下面的详细信息，让我们更好地认识你。")

    }
    .backgroundColor(parse('rgba(67, 110, 238, 1)').space)
  }
}
