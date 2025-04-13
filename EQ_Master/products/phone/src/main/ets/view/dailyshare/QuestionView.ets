import { DAILY_SHARE_LIST_QUESTION } from "../../common/constants/DailyShareList"
import { dailyShareToQuestionDataConverter } from "../../model/Converter"
import { DailyShare, questionData, stance } from "../../server/dailyshare/DailyShareData"

@Entry
@Component
export struct DailyShareQuestionSwiper{

  build() {
    Swiper(){
      DailyShareQuestion()
      DailyShareQuestion()
      DailyShareQuestion()
      DailyShareQuestion()
    }
    .indicator(
      Indicator.dot()
        .itemHeight(8)
        .itemWidth(8)
        .selectedItemWidth(13)
        .selectedItemHeight(13)
    )
  }
}

// @Entry
@Component
export struct DailyShareQuestion{
  @Prop Question:questionData
  private converter=new dailyShareToQuestionDataConverter()
  private q1:DailyShare = {
    id: 'question-1',
    createdAt: '2025-01-05 15:32:23',
    updatedAt: '',
    isLike: false,
    isStar: false,
    isShare: false,
    type: 'question',
    title: '处理工作时意见分歧',
    context: '你正在办公室里忙碌地整理着即将提交给客户的项目报告。这份报告你已经加班加点准备了一周，每一个数据、每一张图表都经过了你的仔细校对和分析。你对自己的工作成果感到满意，认为它既全面又专业。\n' +
      '然而，当你在团队会议上展示你的报告时，你的同事提出了不同的意见。他指出，虽然你的报告在数据和分析上无可挑剔，但是在呈现方式上过于复杂，可能会让客户难以理解。他认为报告应该更加简洁直观，以便客户能够迅速抓住重点。\n' +
      '此时你会',
    picture: 'meeting1.jpg',
    likes: 123,
    view: 3300,
    commentCount: 0,
    favorite: 500,
    share: 1
  }
  private q2:DailyShare = {
    id: "question-2",
    createdAt: "2025-01-05 15:32:24",
    updatedAt: "",
    isLike: false,
    isStar: false,
    isShare: false,
    type: "question",
    title: "提出建议无人回应",
    context: "你刚刚完成了一个自认为能够极大提升团队效率的建议。你详细地解释了这个建议的每一个细节，包括它如何能够节省成本、提高生产力，以及它对公司未来发展的潜在影响。\n" +
      "然而，当你结束演讲，询问是否有任何问题或评论时，会议室里陷入了一片沉默。你环顾四周，看到同事们有的低头看着自己的笔记本，有的在手机上滑动，还有的只是静静地坐着，没有任何人对你的提案发表意见。\n" +
      "你感到有些尴尬，但同时也有些困惑。面对这样的情景，你会",
    picture: "meeting2.jpg",
    likes: 0,
    view: 0,
    commentCount: 0,
    favorite: 0,
    share: 0
  }
  private q3:DailyShare = {
  id: "question-3",
  createdAt: "2025-01-05 15:32:26",
  updatedAt: "",
  isLike: false,
  isStar: false,
  isShare: false,
  type: "question",
  title: "面试官问到有什么缺点",
  context: "面试室内，灯光柔和而明亮，营造出一种专业而又不过于压迫的氛围。你坐在面试官对面，一张简洁的桌子隔开了你们。你尽力展现出自己的专业和自信，回答着面试官关于你的工作经验和专业技能的问题，你的回答条理清晰，逻辑严密，你能感受到面试官对你的回答表示满意。\n" +
  "然而，当面试官突然转变话题，问你的弱点是什么时，你感到有些尴尬。这个问题像一颗小石子投入平静的湖面，打破了你之前的自信和流畅。面试官的目光坚定而直接，他们的眼神中透露出一种期待，似乎在寻找一个真实的、非标准化的答案。\n" +
  "但自己说出自己的缺点总让人觉得非常尴尬，遇到这种情况，你会",
  picture: "interview1.jpg",
  likes: 0,
  view: 0,
  commentCount: 0,
  favorite: 0,
  share: 0
}
  private stance:stance = Object({
    content:'这个问题门道深！这时候可千万别真的回复[我有拖延症],[我比较内向]!aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    support:0,
    oppose:0
  })

  initTest(){
    this.Question = this.converter.convert(this.q1,this.stance)
    // this.Question.setRelatedQuestion(this.converter.convert((this.q2)))
    this.Question.setRelatedQuestion([this.converter.convert(this.q2,this.stance),this.converter.convert(this.q3,this.stance)])
  }

  aboutToAppear(): void {
    this.initTest()
  }


  build() {
    // Column() { // 背景,为了观察边角
      Column() {
        Column({space:10}) {
          Row() { // 标题行
            Image($r('app.media.hot'))
              .height('28vp')
              .aspectRatio(1)
            Text(this.Question.title)
              .margin({ left: 5 })
              .fontSize(23)
              .fontWeight(FontWeight.Bold)
          }

          Row() { //图片及其右侧
            Image(this.Question.icon)
              .height('100vp')
              .width('100vp')
              .aspectRatio(1)
              .borderRadius(5)
            Column({space:10}) { //图片的右侧
              Row({ space: 5 }) { //tags
                ForEach(this.Question.tags, (item: string) => {
                  Text('#' + item)
                    .borderRadius('10%')
                    .backgroundColor('#d4dffc')
                    .padding({left:5,right:5,top:2,bottom:2})
                    .fontSize(13)
                    .fontWeight(FontWeight.Bold)
                })
              }

              Text(this.Question.content)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(2)
                .width('70%')
                .fontWeight(FontWeight.Bold)
              Row({space:10}) { // 阅读和热议
                Row({ space: 3 }) {
                  Image($r('app.media.view'))
                    .height('20vp')
                    .aspectRatio(1)
                  Text(this.Question.view.toString() + '次阅读')
                    .fontColor(Color.Gray)
                    .fontSize(10)
                    .fontWeight(FontWeight.Bold)
                }

                Row({ space: 3 }) {
                  Image($r('app.media.interact_red'))
                    .height('15vp')
                    .aspectRatio(1)
                  Text(this.Question.total_interact.toString() + '条热议')
                    .fontColor(Color.Red)
                    .fontSize(10)
                    .fontWeight(FontWeight.Bold)
                }
              }
              .width('70%')
              .justifyContent(FlexAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .margin({left:10,right:10})
            .height('100vp')
          }

          Row() { //最热门的评论
            Text(this.Question.interaction.content)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .padding({top:5,bottom:5,left:2})
              .fontSize(12)
              .width('80%')
            Image($r('app.media.like'))
              .height('20vp')
              .aspectRatio(1)
          }
          .backgroundColor('#edf2ff')
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .borderRadius('5%')

          Column() { //其他相关问题
            Row() {
              Image($r('app.media.hot_orange'))
                .height('28vp')
                .aspectRatio(1)
              Text('大家还在讨论:')
                .margin({ left: 5 })
                .fontWeight(FontWeight.Bold)
            }
            Column() {
              ForEach(this.Question.relatedQuestion, (item: questionData, count: number) => {
                Row() {
                  Text(item.title)
                    .margin({left:10,top:1,bottom:1})
                    .fontSize(12)
                  Row({space:3}){
                    Image($r(count == 1 ? 'app.media.interact' : 'app.media.favourite'))
                      .height('20vp')
                      .aspectRatio(1)
                    Text(count == 1 ? item.total_interact.toString() : item.fav.toString())
                  }
                  .margin({right:10})
                }
                .backgroundColor('#d0dcff')
                .width('100%')
                .borderRadius('10%')
                .margin(3)
                .justifyContent(FlexAlign.SpaceBetween)
              })
            }
          }
          .alignItems(HorizontalAlign.Start)
        }

        .backgroundColor(Color.White)
        .margin(15)
        .alignItems(HorizontalAlign.Start)
      }
      .margin(5)
      .padding({bottom:20})
      .backgroundColor(Color.White)
      .borderRadius(10)
      .shadow({ // 阴影
        radius: 4,
        color: Color.Gray,
        // offsetX: 20,
        offsetY: 3
      })
    // }
    // .backgroundColor(Color.Black)
  }
}

export { questionData }
