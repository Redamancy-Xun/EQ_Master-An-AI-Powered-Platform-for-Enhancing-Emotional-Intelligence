import { CommonConstants } from '../common/constants/CommonConstants';

@Component
export struct TitleView {
  // @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('isFoundSelected') isFoundSelected: boolean = false;

  build() {
    Column() {
      Stack() {
        Row() {
          Text($r('app.string.found'))
            .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_selected') : $r('app.float.title_font_size_normal'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .fontColor(Color.Black)
            .opacity(this.isFoundSelected ? $r('app.float.title_opacity_selected') :
            $r('app.float.title_opacity_normal'))
            .onClick(()=>{
              this.isFoundSelected = true;
            })

          Text($r('app.string.follow'))
            .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_normal') :
            $r('app.float.title_font_size_selected'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .fontColor(Color.Black)
            .margin({
              // left: new BreakpointType($r('app.float.title_margin_left_sm'), $r('app.float.title_margin_left_md'),
              //   $r('app.float.title_margin_left_lg')).getValue(this.currentBreakpoint)
            })
            .opacity(this.isFoundSelected ? $r('app.float.title_opacity_normal') :
            $r('app.float.title_opacity_selected'))
            .onClick(()=>{
              this.isFoundSelected = false;
            })
        }
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .justifyContent(FlexAlign.Center)

        // SearchBarView()
        //   .width(new BreakpointType($r('app.float.search_bar_view_width_sm'), $r('app.float.search_bar_view_width_md'),
        //     $r('app.float.search_bar_view_width_lg')).getValue(this.currentBreakpoint))
      }
      .alignContent(Alignment.End)
      .padding({
        // left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        //   $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
        // right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        //   $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
      })
    }
    .height($r('app.float.hot_title_height'))
    // .borderColor($r('app.color.hot_title_border_color'))
    // .borderWidth({
    //   bottom: new BreakpointType($r('app.float.hot_title_border_width_normal'),
    //     $r('app.float.hot_title_border_width_normal'), $r('app.float.hot_title_border_width_more')
    //   ).getValue(this.currentBreakpoint)
    // })
  }
}