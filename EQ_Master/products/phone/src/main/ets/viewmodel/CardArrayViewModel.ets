import { DailyShareItem } from '../common/constants/DailyShareList';
import { PICTURE_MAP } from '../common/constants/PictureConstants';
import { COMMENT_LIST } from '../model/CommentModel';
import { DailyShare } from '../server/dailyshare/DailyShareData';
import { CardItem } from './CardViewModel';
import { CommentItem } from './CommentViewModel';
import { CommentItemInterface } from './CommentViewModel';

export class CardArray {
  cardArray: CardItem[] = [];

  constructor(dailyShareListByTime: Array<DailyShareItem>) {
    dailyShareListByTime.forEach((item: DailyShareItem) => {
      let cardItem: CardItem = {
        dailyShareId: item.id ? item.id : '',
        icon: $r('app.media.login_logo'),
        name: 'EQ_Master',
        authorType: 'EQ_Master官方账号',
        content: item.context ? item.context : '',
        pictureArray: [PICTURE_MAP.get(item.picture ? item.picture : '')],
        // commentList: item.commentList;
        isLike: item.isLike ? item.isLike : false,
        isStar: item.isStar ? item.isStar : false,
        isShare: item.isShare ? item.isShare : false,
        shareCount: item.share ? item.share : 0,
        likeCount: item.likes ? item.likes : 0,
        CommonCount: item.commentCount ? item.commentCount : 0,
        viewCount: item.view ? item.view : 0,
        starCount: item.favorite ? item.favorite : 0,
        createTime: item.createdAt ? item.createdAt : new Date(),
        commentList: []
      }
      COMMENT_LIST.forEach((item: CommentItemInterface) => {
        cardItem.commentList.push(new CommentItem(item));
      });
      this.cardArray.push(cardItem);
    });
  }
}
