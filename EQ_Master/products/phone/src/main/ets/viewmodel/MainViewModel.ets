/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

import ItemData from '../model/ItemDataModel';

/**
 * Binds data to components adn provides interfaces.
 */
export class MainViewModel {
  /**
   * Get swiper image data.
   *
   * @return {Array<Resource>} swiperImages.
   */
  getSwiperImages(): Array<Resource> {
    let swiperImages: Resource[] = [
      $r('app.media.ic_fig1'),
      $r('app.media.ic_fig2'),
      $r('app.media.ic_fig3'),
      $r('app.media.ic_fig4')
    ];
    return swiperImages;
  }

  /**
   * Get data of the first grid.
   *
   * @returns {Array<PageResource>} firstGridData.
   */
  getFirstGridData(): Array<ItemData> {
    let firstGridData: ItemData[] = [
      new ItemData($r('app.string.my_favorite'), $r('app.media.ic_love')),
      new ItemData($r('app.string.history_record'), $r('app.media.ic_record')),
      new ItemData($r('app.string.message'), $r('app.media.ic_message')),
      new ItemData($r('app.string.shopping_cart'), $r('app.media.ic_shopping')),
      new ItemData($r('app.string.my_goal'), $r('app.media.ic_target')),
      new ItemData($r('app.string.group'), $r('app.media.ic_circle')),
      new ItemData($r('app.string.favorites'), $r('app.media.ic_favorite')),
      new ItemData($r('app.string.recycle_bin'), $r('app.media.ic_recycle'))
    ];
    return firstGridData;
  }

  /**
   * Get data of the second grid.
   *
   * @returns {Array<PageResource>} secondGridData.
   */
  getSecondGridData(): Array<ItemData> {
    let secondGridData: ItemData[] = [
      new ItemData($r('app.string.main_top'), $r('app.media.ic_top'), $r('app.string.main_text_top')),
      new ItemData($r('app.string.main_new'), $r('app.media.ic_new'), $r('app.string.main_text_new')),
      new ItemData($r('app.string.main_brand'), $r('app.media.ic_brand'), $r('app.string.main_text_brand')),
      new ItemData($r('app.string.main_found'), $r('app.media.ic_found'), $r('app.string.main_text_found')),
    ];
    return secondGridData;
  }

  /**
   * Get data of the setting list.
   *
   * @returns  {Array<PageResource>} settingListData.
   */
  getSettingListData(): Array<ItemData> {
    let secondListData: ItemData[] = [
      new ItemData($r('app.string.setting_list_news'), $r('app.media.ic_news'), $r('app.string.setting_toggle')),
      new ItemData($r('app.string.setting_list_data'), $r('app.media.ic_data')),
      new ItemData($r('app.string.setting_list_menu'), $r('app.media.ic_menu')),
      new ItemData($r('app.string.setting_list_about'), $r('app.media.ic_about')),
      new ItemData($r('app.string.setting_list_storage'), $r('app.media.ic_storage')),
      new ItemData($r('app.string.setting_list_privacy'), $r('app.media.ic_privacy'))
    ];
    return secondListData;
  }
}

export default new MainViewModel();