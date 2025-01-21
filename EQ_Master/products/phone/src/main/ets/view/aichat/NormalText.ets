import { BaseConstants } from '../../common/constants/BaseConstants';

@Component
export struct NormalText {
  @Prop data: ResourceStr;
  @Prop fontSize: Resource = BaseConstants.FONT_SIZE_TWELVE;
  @Prop fontColor: Resource = $r('app.color.font_color_black_two');
  @Prop fontWeight: number = BaseConstants.FONT_WEIGHT_FOUR;
  // @Prop fontFamily: Resource = BaseConstants.FONT_FAMILY_NORMAL;

  build() {
    Text(this.data)
      // .fontFamily(this.fontFamily)
      .fontSize(this.fontSize)
      .fontColor(this.fontColor)
      .textAlign(TextAlign.Start)
      .lineHeight($r('app.float.text_line_height_five'))
      .fontWeight(this.fontWeight)
      .copyOption(CopyOptions.LocalDevice)
  }
}