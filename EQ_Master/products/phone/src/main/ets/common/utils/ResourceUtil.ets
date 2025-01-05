import { BreakpointType } from './BreakpointType';

export class ResourceUtil {
  /**
   * Page column padding.
   */
  private static pageColPadding: BreakpointType<Resource> = new BreakpointType($r('app.float.page_col_padding_sm'),
    $r('app.float.page_col_padding_md'), $r('app.float.page_col_padding_lg'));

  /**
   * Common image size list.
   */
  private static commonImgSize: Resource[] = [$r('app.float.common_image_size_1'), $r('app.float.common_image_size_2'),
    $r('app.float.common_image_size_3'), $r('app.float.common_image_size_4'), $r('app.float.common_image_size_5'),
    $r('app.float.common_image_size_6'), $r('app.float.common_image_size_7'), $r('app.float.common_image_size_8'),
    $r('app.float.common_image_size_9'), $r('app.float.common_image_size_10'), $r('app.float.common_image_size_11')];

  /**
   * Common background color list.
   */
  private static commonBackgroundColor: Resource[] = [$r('app.color.common_background_1'),
    $r('app.color.common_background_2'), $r('app.color.common_background_3')];

  /**
   * Common border color list.
   */
  private static commonBorderColorList: Resource[] = [$r('app.color.common_border_color_1'),
    $r('app.color.common_border_color_2'), $r('app.color.common_border_color_3'),
    $r('app.color.common_border_color_4')];

  /**
   * Common divider color.
   */
  private static commonDividerColor: Resource = $r('app.color.common_divider_color');

  /**
   * Common border radius list.
   */
  private static commonBorderRadius: Resource[] = [$r('app.float.common_border_radius_1'),
    $r('app.float.common_border_radius_2'), $r('app.float.common_border_radius_3'),
    $r('app.float.common_border_radius_4'), $r('app.float.common_border_radius_5'),
    $r('app.float.common_border_radius_6'), $r('app.float.common_border_radius_7'),
    $r('app.float.common_border_radius_8'), $r('app.float.common_border_radius_9'),
    $r('app.float.common_border_radius_10')];

  static getPageColPadding(): BreakpointType<Resource> {
    return ResourceUtil.pageColPadding;
  }

  static getCommonImgSize(): Resource[] {
    return ResourceUtil.commonImgSize;
  }

  static getCommonBackgroundColor(): Resource[] {
    return ResourceUtil.commonBackgroundColor;
  }

  static getCommonBorderColor(): Resource[] {
    return ResourceUtil.commonBorderColorList;
  }

  static getCommonDividerColor(): Resource {
    return ResourceUtil.commonDividerColor;
  }

  static getCommonBorderRadius(): Resource[] {
    return ResourceUtil.commonBorderRadius;
  }
}