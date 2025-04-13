import { PICTURE_MAP } from "../common/constants/PictureConstants";
import { DailyShare,stance,questionData, tipData, singleChoice, storyData } from "../server/dailyshare/DailyShareData";
import { HotItem} from "./HotModel";

export interface Converter<S,T>{
  convert(source:S,instance?:object):T;
}

export class dailyShareToHotItemConverter implements Converter<DailyShare,HotItem>{
  private p:HotItem = Object()
  private index:number = 0
  public setIndex(index:number):number{
    this.index = index
    return index
  }
  public convert(source:DailyShare):HotItem {
    this.p = {
      index: this.index,
      icon: PICTURE_MAP.get(source.picture? source.picture : ''),
      dailyShareId: source.id ? source.id : '',
      title: source.title ? source.title : '',
      content: source.context ? source.context : '',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: source.likes + source.view + source.commentCount + source.favorite + source.share,
      upDownIcon: $r('app.media.ic_up')
    }
    return this.p
  }
}

export class dailyShareToQuestionDataConverter implements Converter<DailyShare,questionData>{
  public convert(source:DailyShare, instance:stance):questionData {
    let p: questionData = new questionData({
      basicDataConstructor: {
        title: source.title,
        tags: ['职场沟通', '面试技巧'],
        icon: PICTURE_MAP.get(source.picture ? source.picture : ''),
        content: source.context,
        view: source.view,
        like: source.likes,
        fav: source.favorite,
        share: source.share,
        total_interact: 0
      },
      relatedQuestion:[],
      interaction:instance
    })
    return p
  }
}

export class dailyShareToTipDataConverter implements  Converter<DailyShare,tipData>{
  public convert(source: DailyShare, instance:singleChoice): tipData {
    let p: tipData = new tipData({
      basicDataConstructor:{
        title:source.title,
        tags:['职场沟通', '面试技巧'],
        icon:PICTURE_MAP.get(source.picture ? source.picture : ''),
        content:source.context,
        view:source.view,
        like:source.likes,
        fav:source.favorite,
        share:source.share,
        total_interact:0
      },
      rate:0,
      singleChoice:instance
    })
    return p
  }
}

export class dailyShareToStoryDataConverter implements Converter<DailyShare,storyData>{
  public convert(source: DailyShare): storyData {
    let p: storyData = new storyData({
      basicDataConstructor:{
        title:source.title,
        tags:['职场沟通', '面试技巧'],
        icon:PICTURE_MAP.get(source.picture ? source.picture : ''),
        content:source.context,
        view:source.view,
        like:source.likes,
        fav:source.favorite,
        share:source.share,
        total_interact:0
      },
    })
    return p
  }

}
