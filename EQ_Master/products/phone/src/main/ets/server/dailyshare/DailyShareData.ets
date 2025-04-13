import { UserInfo } from "../user/UserData";

//后端基础返回值
export class DailyShare {
  id: string = '';
  createdAt: string = '';
  updatedAt: string = '';
  isLike: boolean = false;
  isStar: boolean = false;
  isShare: boolean = false;
  type: string = '';
  title: string = '';
  context: string = '';
  picture: string = '';
  likes: number = 0;
  view: number = 0;
  commentCount: number = 0;
  favorite: number = 0;
  share: number = 0;
}

// 基类,表示每日分享中的互动类型
// 互动类型一律用参数直接构造而非接口
class interactOption {
  content:string = ''

  constructor(content:string = '') {
    this.content = content
  }
}
// 互动类型的一种, 用户在两种说法中选择支持的
interface stanceConstructor{
  content:string
  support:number
  oppose:number
}
export class stance extends interactOption{
  //支持数
  support:number = 0
  //反对数
  oppose:number = 0
  // 参与交互的人的id
  participant:Array<string> = []

  constructor(
    content: string = '',
    support: number = 0,
    oppose: number = 0
  ) {
    super(content)
    this.support = support
    this.oppose = oppose
  }

  addParticipant(userId:string){
    this.participant.push(userId)
    if(this.participant.length==3){
      this.participant.shift()
    }

  }



}
// 互动类型的一种, 用户需要选择正确答案
interface singleChoiceConstructor {
  content: string;
  correctIndex: number;
  choices: string[];
}

export class singleChoice extends interactOption {
  correctIndex:number = -1
  choices:Array<string> = []

  constructor(
    content: string = '',
    correctIndex: number = -1, // 默认值
    choices: string[] = [] // 默认空数组
  ) {
    super(content)
    this.correctIndex = correctIndex
    this.choices = choices
  }
}

// 每日分享展示页中的基本数据格式, 问题,小技巧,故事的数据格式由这个衍生
// 每日分享基本数据一律用接口构造
interface basicDataConstructor {
  title: string;
  tags: string[];
  content: string;
  icon?: Resource; // 可选参数
  view: number;
  like: number;
  fav: number;
  share: number;
  total_interact: number;
}

class basicData {
  title:string = ''
  tags:Array<string> = []
  content:string = ''
  icon:Resource|undefined = undefined
  view:number = 0
  like:number = 0
  fav:number = 0
  share:number = 0
  total_interact:number = 0


  constructor(config: basicDataConstructor) {
    this.title = config.title
    this.tags = config.tags
    this.content = config.content
    this.icon = config.icon
    this.view = config.view
    this.like = config.like
    this.fav = config.fav
    this.share = config.share
    this.total_interact = config.total_interact
  }
}

// 每日分享展示页中的问题
interface questionDataConstructor{
  basicDataConstructor: basicDataConstructor
  relatedQuestion:Array<questionData>
  interaction:stance |stanceConstructor
}
export class questionData extends basicData{
  relatedQuestion:Array<questionData> = []
  interaction:stance = Object()

  constructor(config:questionDataConstructor) {
    super(config.basicDataConstructor)
    this.relatedQuestion = config.relatedQuestion
    this.interaction = config.interaction instanceof stance
      ? config.interaction
      : new stance(
        config.interaction.content,
        config.interaction.support,
        config.interaction.oppose
      )
  }

  setRelatedQuestion(source?:questionData|Array<questionData>){
    if(source instanceof questionData){
      this.relatedQuestion.push(source)
    }
    else if(source instanceof Array){
      this.relatedQuestion = source
    }
  }
}


interface tipDataConstructor {
  basicDataConstructor: basicDataConstructor;
  rate: number;
  singleChoice: singleChoice | singleChoiceConstructor;
}

export class tipData extends basicData{
  // 有效性评分
  effectiveness:number = 0
  singleChoice:singleChoice = new singleChoice()

  constructor(config: tipDataConstructor) {
    super(config.basicDataConstructor) // 传递基础数据给父类

    // 初始化本类属性
    this.effectiveness = config.rate

    // 智能初始化嵌套对象
    this.singleChoice = config.singleChoice instanceof singleChoice
      ? config.singleChoice
      : new singleChoice(
        config.singleChoice.content,
        config.singleChoice.correctIndex,
        config.singleChoice.choices
      )
  }

  // 静态工厂方法 - 用于从API数据直接创建实例
  // static fromAPI(data: any): tipData {
  //   return new tipData({
  //     ...data,
  //     singleChoice: new singleChoice(
  //       data.singleChoice.content,
  //       data.singleChoice.correctIndex,
  //       data.singleChoice.options // 假设后端字段名为options
  //     )
  //   })
  // }

  // // 更新数据的方法
  // updateStats(update: Partial<Pick<basicData, 'view' | 'like' | 'fav' | 'share' | 'total_interact'>>) {
  //   Object.assign(this, update)
  // }

}

interface storyDataConstructor{
  basicDataConstructor:basicDataConstructor
  // mood:Array<number>
  // interaction: stance|stanceConstructor
}

export class storyData extends basicData{
  // 心情/情绪评分
  mood:Array<number> = [0,0,0,0,0,0,0,0]
  interaction: Array<stance> = []

  constructor(config:storyDataConstructor) {
    super(config.basicDataConstructor)
  }

  setStances(...instance:Array<stance>){
    this.interaction = this.interaction.concat(instance)
  }

  updateMood(index:number){
    this.mood[index]++
  }
}