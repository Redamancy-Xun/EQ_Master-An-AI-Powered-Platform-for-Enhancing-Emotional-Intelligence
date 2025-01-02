/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

/**
 * List item data entity.
 */
export default class ItemDataModel {
  /**
   * Text of list item.
   */
  title: Resource;

  /**
   * Image of list item.
   */
  img?: Resource;

  /**
   * Other resource of list item.
   */
  others?: Resource;

  constructor(title: Resource, img?: Resource, others?: Resource) {
    this.title = title;
    this.img = img;
    this.others = others;
  }
}