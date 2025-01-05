import { CardItemInterface } from '../model/CardListModel';
import { COMMENT_LIST } from '../model/CommentModel';
import { PICTURE_ARRAY_LIST } from '../model/PictureArrayModel';
import { CommentItem, CommentItemInterface } from './CommentViewModel';

export class CardItem implements CardItemInterface {
  dailyShareId: string = '';
  icon: ResourceStr = $r('app.media.login_logo');
  name: ResourceStr = 'EQ_Master';
  authorType: ResourceStr = 'EQ_Master官方账号';
  content: string = '';
  pictureArray: (Resource | undefined)[] = [];
  commentList: CommentItem[] = [];
  isLike: boolean = false;
  isStar: boolean = false;
  isShare: boolean = false;
  likeCount: number = 0;
  CommonCount: number = 0;
  viewCount: number = 0;
  shareCount: number = 0;
  starCount: number = 0;
  createTime: Date | string = new Date();

  // constructor(card: CardItem) {
  //   this.icon = card.icon;
  //   this.name = card.name;
  //   this.authorType = card.authorType;
  //   this.content = card.content;
  //   this.pictureArray = card.pictureArray;
  //   // this.commentList = card.commentList;
  //   this.isLike = card.isLike;
  //   this.isStar = card.isStar;
  //   this.isShare = card.isShare;
  //   this.likeCount = card.likeCount;
  //   this.CommonCount = card.CommonCount;
  //   this.viewCount = card.viewCount;
  //   this.shareCount = card.shareCount;
  //   this.starCount = card.starCount;
  //   this.createTime = card.createTime;
  //
  //
  //   COMMENT_LIST.forEach((item: CommentItemInterface) => {
  //     this.commentList.push(new CommentItem(item));
  //   });
  // }
}