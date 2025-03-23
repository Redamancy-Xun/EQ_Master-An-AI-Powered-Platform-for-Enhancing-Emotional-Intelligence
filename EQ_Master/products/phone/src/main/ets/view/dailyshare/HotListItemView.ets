import { CommonConstants } from '../../common/constants/CommonConstants';
import { HotItemInterface } from '../../model/HotModel';
import { router } from '@kit.ArkUI';
import Logger from '../../common/utils/Logger';
import PreferenceModel from '../../model/PreferenceModel';

@Component
export struct HotListItemView {
  item: HotItemInterface = {
    index: 0,
    dailyShareId: '',
    icon: undefined,
    title: '',
    content: '',
    stateIcon: '',
    clickCount: 0,
    upDownIcon: ''
  };
  showDetail: boolean = false;
  indexWidth: ResourceStr = $r('app.float.index_width_normal');
  indexIconGap: ResourceStr = $r('app.float.index_icon_gap_normal');

  build() {
    Row() {
      Row() {
        Text(`${this.item.index}`)
          .fontSize($r('app.float.index_font_size'))
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor(this.isTopThree() ? $r('app.color.top_three_color') : $r('app.color.normal_index_color'))
          .textAlign(TextAlign.End)
          .width(this.indexWidth)

        Row() {
          if (this.isShowDetail()) {
            Image(this.item.icon)
              .width($r('app.float.list_item_icon_width'))
              .aspectRatio(1)
              .borderRadius($r('app.float.item_icon_br'))
          }

          Column({ space: CommonConstants.TITLE_CONTENT_SPACE }) {
            Row() {
              Text(this.item.title)
                .fontSize($r('app.float.rank_item_font_size'))
                .fontWeight(FontWeight.Normal)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Image(this.item.stateIcon)
                .height($r('app.float.state_icon_height'))
                .aspectRatio(1)
                .margin({ left: $r('app.float.state_icon_margin_left') })
            }
            .justifyContent(FlexAlign.Start)
            .width(this.isShowDetail()?'80%':'90%')

            Text(this.item.content)
              .fontSize($r('app.float.content_font_size'))
              .fontWeight(FontWeight.Normal)
              .fontColor($r('app.color.content_color'))
              .visibility(this.isShowDetail() ? Visibility.Visible : Visibility.None)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({
            left: this.isShowDetail() ? CommonConstants.WINDOW_PADDING_HALF_SM : $r('app.float.zero')
          })
          .layoutWeight(1)
        }
        .layoutWeight(1)
        .margin({ left: this.indexIconGap })
        .justifyContent(FlexAlign.Start)

        Row() {
          Text(`${this.item.clickCount}`)
            .fontSize($r('app.float.click_count_font_size'))
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.End)
            .fontColor($r('app.color.click_count_color'))

          Image(this.item.upDownIcon)
            .width($r('app.float.up_down_icon_width'))
            .aspectRatio(1)
        }
        .height(CommonConstants.FULL_PERCENT)
        .borderRadius($r('app.float.rank_list_rd'))
        .margin({
          right: $r('app.float.icon_name_margin_left')
        })
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height((this.isShowDetail()) ? $r('app.float.top_three_height') : $r('app.float.normal_item_height'))
    .onClick(() => {
      PreferenceModel.putPreference('dailyShareId', this.item.dailyShareId);

      router.pushUrl({
        url: CommonConstants.DAILY_SHARE_DETAIL_PAGE_URL
      }).catch((error: Error) => {
        Logger.error(CommonConstants.DAILY_SHARE_DETAIL_PAGE_TAG, 'DailyShareShowTypePage pushUrl error ' + JSON.stringify(error));
      });
    })
  }

  isShowDetail(): boolean {
    return this.showDetail || this.isTopThree();
  }

  isTopThree(): boolean {
    return this.item.index <= CommonConstants.TOP_COUNT;
  }
}