import { dailyShareToStoryDataConverter } from "../../model/Converter"
import { DailyShare, stance, storyData } from "../../server/dailyshare/DailyShareData"


@Entry
@Component
export struct DailyShareStory {
  @Prop Story:storyData = Object()
  @State selectedStance:number = -1 // 用于选择支持项时的动态颜色变化
  @State selectedEmoji:number = -1 //用于选择情绪表情时的动态颜色变化
  @State emojiPopup: boolean = false

  private emojiList:Array<string> = ['😀', '😃', '😄', '😁', '😆', '😅','😂', '🤣']
  private converter:dailyShareToStoryDataConverter = new dailyShareToStoryDataConverter()
  private s1:DailyShare = {
  id: "story-1",
  createdAt: "2025-01-05 15:32:23",
  updatedAt: "",
  isLike: false,
  isStar: false,
  isShare: false,
  type: "story",
  title: "乔治巧应结婚问题",
  context: "在一次采访中，记者问他：“你已经40多岁了，为什么还不结婚？”这个问题很容易让人感到尴尬，但乔治·克鲁尼回答得既幽默又真诚：“我一直在等待一个像我一样有魅力的人出现。”他用幽默化解了尴尬，同时也表达了自己对婚姻的认真态度。",
  picture: "story1.jpg",
  likes: 0,
  view: 0,
  commentCount: 0,
  favorite: 0,
  share: 0
  }
  private st1:stance = new stance('你好你好你好你好你好好'
    ,0,0)

  initTest(){
    this.Story = this.converter.convert(this.s1)
    this.st1.addParticipant('1')
    this.Story.setStances(this.st1)
    this.Story.setStances(this.st1)
    this.Story.setStances(this.st1)
    this.Story.setStances(this.st1)
  }

  loadParticipantImage(){

  }

  aboutToAppear(): void {
    this.initTest()
  }

  @Builder
  emojiOption(index:number){
    Row({space:10}){
      Text(this.emojiList[index])
        .fontSize(20)
      Text(this.Story.mood[index].toString())
        .fontSize(13)
    }
    .width('21%')
    .borderRadius(5)
    .onClick(()=>{
      this.selectedEmoji = index
    })
    .backgroundColor(this.selectedEmoji == index?'#a9c0ff':'#f5f2f2')
    .margin(5)
  }

  @Builder
  popupBuilder(){
    Column(){
      Row(){
        ForEach(this.emojiList.slice(0,5),(item:string,index:number)=>{
          Text(item)
            .fontSize(13)
            .margin(5)
        })
      }
      Row(){
        ForEach(this.emojiList.slice(5,8),(item:string,index:number)=>{
          Text(item)
            .fontSize(13)
            .margin(5)
        })
      }
    }
    .margin(5)
  }

  @Builder
  stanceArea(instance:stance,index:number){ // 支持/反对选项
    Row(){ // 最外侧背景和边角
      Row(){ //内容
        Text(instance.content)
          .maxLines(3)
          .width('75%')
          .height('46vp')
          .fontSize(13)
          .textOverflow({overflow:TextOverflow.Ellipsis})
        Row(){ //参与活动的用户头像
          ForEach(instance.participant,(item:string)=>{
            Image($r(item))
              .height('75px')
              .width('75px')
              .objectFit(ImageFit.Cover)
          })
        }
        Row(){
          Image($r('app.media.like'))
            .height('20vp')
            .aspectRatio(1)
          Text(instance.support.toString())
            .fontSize(8)
        }
      }
      .onClick(()=>{
        this.selectedStance = index
      })
      .padding({left:5,right:5,top:5,bottom:5})
    }
    .backgroundColor(this.selectedStance == index?'#d0dcff':Color.White)
    .borderRadius(15)
  }

  build() {
    Column(){
      Row({space:0}){
        Image(this.Story.icon) // 用户头像?系统默认头像
          .height('150px')
          .width('150px')
          .borderRadius(30)
          .margin({top:5})
          .objectFit(ImageFit.Cover)
        Column(){ //右边
          Column(){ // 右边故事内容的背景
            Column({space:5}){ //故事内容,为了对齐
              Text(this.Story.title)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({overflow:TextOverflow.Ellipsis})
                .fontSize(18)
              Text(this.Story.content)
                .maxLines(10)
                .fontSize(13)
                .textOverflow({overflow:TextOverflow.Ellipsis})
              Column({space:10}) {
                ForEach(this.Story.interaction, (item: stance,index:number) => {
                  this.stanceArea(item,index)
                })
              }
            }
            .margin({left:15,right:15,top:5,bottom:15})
            .alignItems(HorizontalAlign.Start)
          }
          .margin(5)
          .backgroundColor('#edf2ff')
          .borderRadius(10)
          .width('80%')
          .shadow({ // 阴影
            radius: 4,
            color: Color.Gray,
            offsetY: 3,
          })

          Column(){
            Row(){ // 表情符号区域
              ForEach(this.emojiList.slice(0,4),(item:string,index:number)=>{
                this.emojiOption(index)
              })
            }
            Row(){ // 表情符号区域, 两个结构完全一样
              ForEach(this.emojiList.slice(4,8),(item:string,index:number)=>{
                this.emojiOption(index+4)
              })
            }
            Image($r('app.media.ic_public_add_norm'))
              .height(30)
              .alignSelf(ItemAlign.End)
              .onClick(()=>{
                this.emojiPopup = !this.emojiPopup
              })
              .bindPopup(this.emojiPopup, {
                builder: this.popupBuilder, // 气泡的内容
                placement:Placement.Bottom, // 气泡的弹出位置
                popupColor:Color.Pink, // 气泡的背景色
                onStateChange: (e) => {
                  if (!e.isVisible) {
                    this.emojiPopup = false
                  }
                }
              })
          }
          .margin({left:5,right:15,top:5,bottom:15})
          .alignItems(HorizontalAlign.Start)
          .width('80%')
        }
        .alignItems(HorizontalAlign.Start)

      }
      .margin(5)
      .alignItems(VerticalAlign.Top)

    }

  }
}