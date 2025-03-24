import { PICTURE_MAP } from "../common/constants/PictureConstants";
import { DailyShare } from "../server/dailyshare/DailyShareData";
import { HotItem} from "./HotModel";

export interface Converter<S,T>{
  convert(source:S,...arg:number[]):T;
}

export class dailyShareToHotItemConverter implements Converter<DailyShare,HotItem>{
  public convert(source:DailyShare,index:number):HotItem {
    let p: HotItem = {
      index: index,
      icon: PICTURE_MAP.get(source.picture? source.picture : ''),
      dailyShareId: source.id ? source.id : '',
      title: source.title ? source.title : '',
      content: source.context ? source.context : '',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: source.likes + source.view + source.commentCount + source.favorite + source.share,
      upDownIcon: $r('app.media.ic_up')
    }
    return p
  }
}
