import { dailyShareToTipDataConverter } from "../../model/Converter"
import { DailyShare, singleChoice, tipData } from "../../server/dailyshare/DailyShareData"

@Entry
@Component
export struct DailyShareTip{
  @Prop tip:tipData = Object()
  private converter:dailyShareToTipDataConverter = new dailyShareToTipDataConverter()
  private t1:DailyShare = {
    id: 'tip-1',
    createdAt: '2025-01-05 15:32:23',
    updatedAt: '',
    isLike: false,
    isStar: false,
    isShare: false,
    type: 'tip',
    title: '处理自己消极情绪',
    context: '要想改变我们对于一件事的情绪，首先要改变我们对于这件事的认知方式。\n' +
      '要想改变不良的认知引起的情绪，最好的参考方法是由埃利斯提出的ABC合理情绪疗法。A(Antecedent)指事情的前因，C(Consequence)指事情的后果，有前因必有后果，但是有同样的前因A，产生了不一样的后果C1和C2。这是因为从前因到后果之间，一定会透过一座桥梁B(Bridge)，这座梁就是信念和我们对情境的评价与解释。又因为，同情境之下(A)，不同的人的理念以及评价与解释不同(B1和B2)，所以会得到不同结果(C1和C2)。因此，事情发生的一切根源缘于我们的信念(信念是指人们对事件的想法，解释和评价等)。',
    picture: 'tip6.jpg',
    likes: 0,
    view: 0,
    commentCount: 0,
    favorite: 0,
    share: 0
  }
  private singleChoice:singleChoice = new singleChoice()

  initTest(){
    this.tip = this.converter.convert(this.t1,this.singleChoice)
  }

  aboutToAppear(): void {
    this.initTest()
  }

  @Builder
  count(imageResource:string, count:number){
    Row({space:3}){
      Image($r(imageResource))
        .height('20vp')
        .aspectRatio(1)
      Text(count.toString())
        .fontColor(Color.Gray)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
    }
  }

  build() {
    Row({space:10}){
      Column({space:5}){ //图片左侧
        Row({space:5}){ //标签
          ForEach(this.tip.tags,(item:string)=>{
            Text('#'+ item)
              .borderRadius('10%')
              .backgroundColor('#d4dffc')
              .padding({left:5,right:5,top:2,bottom:2})
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
          })
        }
        .justifyContent(FlexAlign.Start)
        Text(this.tip.title)
          .maxLines(2)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
        Row({space:25}){ // 三个小标
          this.count('app.media.view',this.tip.view)
          this.count('app.media.favourite',this.tip.fav)
          this.count('app.media.rate',this.tip.effectiveness)
        }
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .margin({left:15})
      Image(this.tip.icon)
        .height('100vp')
        .borderRadius(10)
        .margin(5)
    }
    .margin(5)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .shadow({ // 阴影
      radius: 4,
      color: Color.Gray,
      offsetY: 3,
    })
  }

}