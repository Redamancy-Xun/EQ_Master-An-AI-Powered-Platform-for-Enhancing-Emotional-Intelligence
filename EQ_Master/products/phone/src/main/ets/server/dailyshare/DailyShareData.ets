export class DailyShare {

  /**
   * id
   */
  id: string = '';

  /**
   * 创建时间
   */
  // createTime: Date = new Date();
  createdAt: string = '';

  /**
   * 删除时间
   */
  // deleteTime: Date = new Date();
  updatedAt: string = '';

  /**
   * 是否点赞
   */
  isLike: boolean = false;

  /**
   * 是否收藏
   */
  isStar: boolean = false;

  /**
   * 是否转发
   */
  isShare: boolean = false;

  /**
   * 类型
   */
  type: string = '';

  /**
   * 主题
   */
  title: string = '';

  /**
   * 内容
   */
  context: string = '';

  /**
   * 图片
   */
  picture: string = '';

  /**
   * 点赞数
   */
  likes: number = 0;

  /**
   * 浏览数
   */
  view: number = 0;

  /**
   * 评论数
   */
  commentCount: number = 0;

  /**
   * 收藏数
   */
  favorite: number = 0;

  /**
   * 分享数
   */
  share: number = 0;
}