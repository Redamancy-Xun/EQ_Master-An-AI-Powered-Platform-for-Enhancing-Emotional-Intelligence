import { CommonConstants } from '../../common/constants/CommonConstants';
import { CommentItemInterface } from '../../viewmodel/CommentViewModel';

@Component
export struct CommentItemView {
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  // @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  commentItem: CommentItemInterface = {} as CommentItemInterface;
  authorName: ResourceStr = '';
  isDarkMode: boolean = false;

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.commentItem.icon)
            .width($r('app.float.comment_item_icon_width'))
            .aspectRatio(1)
            .borderRadius($r('app.float.comment_item_icon_br'))

          Text(this.commentItem.name)
            .fontSize($r('app.float.comment_item_name_fs'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .margin({ left: $r('app.float.comment_item_name_ml') })
            .fontColor(this.isDarkMode ? Color.White : Color.Black)

          if (this.authorName === this.commentItem.name) {
            Row() {
              Text($r('app.string.author_type_name'))
                .fontSize($r('app.float.author_type_name_fs'))
                .fontWeight(FontWeight.Normal)
                .fontColor(this.isDarkMode ? Color.White : $r('app.color.author_type_name_color'))
            }
            .borderColor(this.isDarkMode ? Color.White : $r('app.color.author_type_name_color'))
            .borderRadius($r('app.float.author_type_name_br'))
            .borderWidth($r('app.float.author_type_name_fw'))
            .padding($r('app.float.author_type_name_padding'))
            .margin({ left: $r('app.float.author_type_name_ml') })
          }
        }
        .height($r('app.float.comment_item_title_height'))
        .justifyContent(FlexAlign.Start)

        Row() {
          Text(`${this.commentItem.favorCount}`)
            .fontSize($r('app.float.comment_item_favor_fs'))
            .fontWeight(FontWeight.Normal)
            .fontColor(this.isDarkMode ? $r('app.color.font_color_dark') : $r('app.color.comment_item_favor_color'))

          Image(this.isDarkMode ? $r('app.media.ic_comment_like') : $r('app.media.ic_public_favor'))
            .width($r('app.float.comment_item_favor_width'))
            .aspectRatio(1)
            .margin({ left: $r('app.float.comment_item_favor_ml') })
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PERCENT)

      Text(this.commentItem.content)
        .fontSize($r('app.float.comment_item_content_fs'))
        .margin({
          left: $r('app.float.comment_item_content_ml')
        })
        .fontColor(this.isDarkMode ? Color.White : Color.Black)

      Row({ space: CommonConstants.TIME_POSITION_SPACE }) {
        Text(this.commentItem.timePosition)
          .fontSize($r('app.float.time_position_fs'))
          .fontWeight(FontWeight.Normal)
          .opacity($r('app.float.time_position_opacity'))
          .fontColor(this.isDarkMode ? Color.White : Color.Black)

        if (this.commentItem.reviewCnt) {
          Row({ space: CommonConstants.REVIEW_COUNT_SPACE }) {
            Text(`${this.commentItem.reviewCnt}`)
              .fontSize($r('app.float.review_count_fs'))
              .fontWeight(FontWeight.Normal)
              .fontColor(this.isDarkMode ? Color.White : Color.Black)
              .opacity($r('app.float.review_count_opacity'))

            Text($r('app.string.replay'))
              .fontSize($r('app.float.replay_fs'))
              .fontWeight(FontWeight.Normal)
              .fontColor(this.isDarkMode ? Color.White : Color.Black)
              .opacity($r('app.float.replay_opacity'))
          }
          .backgroundColor(this.isDarkMode ? $r('app.color.dark_mode_gbc') : $r('app.color.replay_bgc'))
          .borderRadius($r('app.float.replay_board_radius'))
          .padding({
            left: $r('app.float.replay_padding_left'),
            right: $r('app.float.replay_padding_left')
          })
          .height($r('app.float.replay_area_height'))
        } else {
          Text($r('app.string.replay'))
            .fontSize($r('app.float.replay_fs'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .opacity($r('app.float.replay_normal_opacity'))
            .fontColor(this.isDarkMode ? Color.White : Color.Black)
        }
      }
      .width(CommonConstants.FULL_PERCENT)
      .height($r('app.float.time_position_height'))
      .justifyContent(FlexAlign.Start)
      .margin({
        left: $r('app.float.comment_item_content_ml')
      })

      if (this.commentItem.reviewCnt) {
        Column({ space: CommonConstants.REVIEW_COUNT_SPACE }) {
          Text(this.commentItem.subContent)
            .fontColor(this.isDarkMode ? Color.White : Color.Black)
            .fontSize($r('app.float.review_count_normal_fs'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .maxLines(CommonConstants.SUB_CONTENT_MAX_LINES)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text($r('app.string.read_all_replay'))
            .fontSize($r('app.float.read_all_replay_fs'))
            .fontColor(this.isDarkMode ? Color.White : $r('app.color.read_all_replay_fc'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
        }
        .backgroundColor(this.isDarkMode ? $r('app.color.dark_mode_gbc') : $r('app.color.read_all_replay_bgc'))
        .borderRadius($r('app.float.read_all_replay_br'))
        .margin({
          left: $r('app.float.comment_item_content_ml'),
          // right: new BreakpointType<ResourceStr>($r('app.float.read_all_replay_mr_sm'),
          //   this.isFoldHorizontal ? $r('app.float.all_replay_mr_md_fold') : $r('app.float.all_replay_mr_md_normal'),
          //   $r('app.float.replay_all_replay_mr_lg'))
          //   .getValue(this.currentBreakpoint),
          right: $r('app.float.replay_all_replay_mr_lg'),
          bottom: $r('app.float.sub_comment_margin_bottom')
        })
        .alignItems(HorizontalAlign.Start)
        .padding({
          left: $r('app.float.sub_content_pl'),
          right: $r('app.float.sub_content_pl'),
          top: $r('app.float.sub_content_pt'),
          bottom: $r('app.float.sub_content_pt')
        })
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .alignItems(HorizontalAlign.Start)
  }
}