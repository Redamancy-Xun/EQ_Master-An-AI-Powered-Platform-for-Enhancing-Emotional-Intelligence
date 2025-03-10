import { BaseConstants } from '../../common/constants/BaseConstants';

@Component
export struct IntroduceText {
  @Prop data: ResourceStr;
  @Prop fontSize: Resource = $r('app.float.micro_font_size');
  @Prop fontColor: Resource = $r('app.color.font_color_black_two');
  @Prop fontWeight: number = BaseConstants.FONT_WEIGHT_FOUR;

  build() {
    Text(this.data)
      .opacity(0.5)
      // .fontFamily(BaseConstants.FONT_FAMILY_NORMAL)
      .fontSize(this.fontSize)
      .fontColor(this.fontColor)
      .textAlign(TextAlign.Start)
      .lineHeight($r('app.float.text_line_height_five'))
      .fontWeight(this.fontWeight)
  }
}