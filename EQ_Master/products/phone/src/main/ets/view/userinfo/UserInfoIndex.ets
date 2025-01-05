import { http } from '@kit.NetworkKit' // 向后端发送请求
import { BusinessError } from '@kit.BasicServicesKit';

import {userInfo} from './User'
import PreferenceModel from '../../model/PreferenceModel';


// 主标题（Headline）
@Extend(Text) function Headline () {
  .fontWeight(FontWeight.Bold) // 粗体
  .fontSize(32) // 字体大小32px
}

// 副标题（Subheadline）
@Extend(Text) function Subheadline () {
  .fontWeight(FontWeight.Medium) // 中等粗细
  .fontSize(20) // 字体大小20px
}

// 正文文本（Body Text）
@Extend(Text) function BodyText () {
  .fontWeight(FontWeight.Normal) // 正常粗细
  .fontSize(16) // 字体大小16px
}

// 次要文本（Secondary Text）
@Extend(Text) function SecondaryText () {
  .fontWeight(FontWeight.Normal) // 正常粗细
  .fontSize(14) // 字体大小14px
}

// 辅助文本（Caption）
@Extend(Text) function Caption () {
  .fontWeight(FontWeight.Lighter) // 字体较细
  .fontSize(12) // 字体大小12px
}

// 强调文本（Emphasis Text）
@Extend(Text) function EmphasisText () {
  .fontWeight(FontWeight.Bold) // 强调使用粗体
  .fontSize(18) // 字体大小18px
}

// 加粗次要文本（Bold Secondary Text）
@Extend(Text) function BoldSecondaryText () {
  .fontWeight(FontWeight.Medium) // 中等粗细
  .fontSize(14) // 字体大小14px
}

// 小标题（Small Headline）
@Extend(Text) function SmallHeadline () {
  .fontWeight(FontWeight.Bold) // 粗体
  .fontSize(24) // 字体大小24px
}


// ----------------------------------------------------------------------


@Component
struct userImage {//个人主页顶部部分
  @Consume userName:string
  @Consume('pageInfos') pageInfos:NavPathStack
  @Consume nameList:string[]

  private fontColor:string = '#c4d2fa'

  build() {
    Column() {
      Column() {

        Text('个人主页')
          .Subheadline()
          .fontColor(this.fontColor)
          .height('30%')

        Image($r('app.media.login_logo'))
          .height('40%')
          .borderRadius(24)
            //这是为了设置边框
          .padding(3)
          .borderStyle(BorderStyle.Solid)
          .borderWidth(2)
          .borderColor('#FFFFFF')
            //
          .onError(() => {
            console.info('load image fail')
          })
          .onClick(()=>{
            this.pageInfos.pushPath({ name: this.nameList[1] })
            console.info('turn into next page')
          })

        Text(this.userName)
          .Headline()
          .fontColor(this.fontColor)
          .height('30%')
      }
      .width('100%')
      .height('75%')
      .backgroundColor('#436eee')
      .borderRadius({ bottomLeft: 24, bottomRight: 24 })
      .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP])

      Column() {
        Text('Achieve higher emotional')
          .SecondaryText()
          .fontColor('#929292')
        Text('intelligence')
          .SecondaryText()
          .fontColor('#929292')
      }
      .height('25%')
      .justifyContent(FlexAlign.Center)

    }
    .width('100%')
    .height('50%')
    .backgroundColor('#181818')
    .borderRadius({ bottomLeft: 24, bottomRight: 24 })
  }
}


@Component
struct experience{
  @State comment:number = 1800
  @State likes:number = 10001
  @State EQ:number = 99
  build() {
    Column({space:5}){
      Text('Experience:')//粗体
        .fontSize(16)
        .fontWeight(700)
        .alignSelf(ItemAlign.Start)
        .padding({left:20,top:8})
      Row(){
        Column({space:3}){
          Text('评论')
            .fontSize(14)
            .fontWeight(500)
            .fontColor('#ccd0d6')
          Text(this.comment.toString())
            .fontSize(14)
            .fontWeight(800)
        }
        Column({space:3}){
          Text('点赞')
            .fontSize(14)
            .fontWeight(500)
            .fontColor('#ccd0d6')
          Text(this.likes.toString())
            .fontSize(14)
            .fontWeight(800)
        }
        Column({space:3}){
          Text('情商')
            .fontSize(14)
            .fontWeight(500)
            .fontColor('#ccd0d6')
          Text(this.EQ.toString())
            .fontSize(14)
            .fontWeight(800)
        }

      }
      .backgroundColor('#f7f8fa')
      .borderRadius(24)
      .width('90%')
      .height('65%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    // .padding({top:20})
    .width("90%")
    .height('20%')
    .borderRadius(24)
    .backgroundColor('#ffffff')
  }
}

@Entry
@Component
export struct UserInfoIndex {
  // @State TooTmp: ToolbarItem = {'value': "func", 'icon': "./image/ic_public_highlights.svg", 'action': ()=> {}}
  @Provide imageUrl: string = 'app.media.person'
  @Provide userName: string = '未登录'
  @Provide signature: string = ""
  @State telephone:string = "13738780768"
  @State password:string = "a13738780768"
  // @State imageUrl: string = 'app.media.person'
  // @State userName: string = '未登录'//临时用state简化
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @Provide nameList:string[] = ["测试成绩","修改个人信息"]

  @State isLoggedIn: boolean = false; // 用户是否已登录

  private fontColor:string = '#c4d2fa'

  // 页面加载时检查登录状态并获取用户信息
  onPageShow(): void {
    console.log("加载登陆状态")
    this.login()
    // this.checkLoginStatus()
    // if (this.isLoggedIn) {
    //   this.getUserInfo()
    // }
    // else{
    //   this.login()
    //   this.getUserInfo()
    // }
  }

  // 检查用户是否已登录
  checkLoginStatus(){ // 保存结果在isLoggedIn中. api返回0: 未登录;1: 已登录
    const req = http.createHttp()
    // 假设通过某个API接口检查用户登录状态
    req.request('https://eqmaster.redamancyxun.fun:8080/user/checkLogin',{
      method: http.RequestMethod.GET,
      header: {
        'session': '3504901a-33bd-421d-b3a4-e9e486638113'
      },
    }, (err:BusinessError, res:http.HttpResponse)=>{
      if(!err){
        this.isLoggedIn = Boolean(res.result)
        console.log("login status:",this.isLoggedIn)
      }
      else{
        console.info('checkLoginStatus: error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        req.off('headersReceive');
        // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
        req.destroy();
      }

    })
  }

  getUserInfo(){
    const req = http.createHttp()
    // 假设通过某个API接口检查用户登录状态
    req.request('https://eqmaster.redamancyxun.fun:8080/user/getUserInfo',{
      method: http.RequestMethod.GET,
      header: {
        'session': PreferenceModel.putPreference('session', '')
      },
    }, (err:BusinessError, res:http.HttpResponse)=>{
      if(!err){
        let data:userInfo = JSON.parse(res.result.toString());
        this.userName = data.result.username
        console.log("get user info: userName is", this.userName)
      }
      else {
        console.info('getUserInfo: error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        req.off('headersReceive');
        // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
        req.destroy();
      }
    })
  }

  login(){
    const req = http.createHttp()
    // 假设通过某个API接口检查用户登录状态
    req.request('https://eqmaster.redamancyxun.fun:8080/user/login?telephone=13738780768&password=a13738780768',{
      method: http.RequestMethod.POST,
      header: {
        'session': '7eabd431-817f-49e7-ae84-cca87c24bd3f',
      },
      // extraData:{ // 存在问题
      //   telephone: this.telephone,
      //   password: this.password
      // },
    },(err:BusinessError,res:http.HttpResponse)=>{
      if(!err){
        console.log("login successfully")
        console.info('Result:' + JSON.stringify(res.result));
        let data:userInfo = JSON.parse(res.result.toString());
        this.userName = data.result.username
        this.signature = data.result.signature
        console.log("get user info: userName is", this.userName)
      }
      else{
        console.info('login: error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        req.off('headersReceive');
        // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
        req.destroy();
      }
    })
  }


  @Builder
  PageMap(name: string) {
    if (name === this.nameList[0]) {
      testResult()
    } else if (name === this.nameList[1]) {
      changeProfile()
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp()
    }
  }
  //用于实现箭头标志
  @Builder OverlayNode() {
    Column() {
      Image('./image/ic_public_arrow_right.svg')
        .height('100%')
        .padding({right: 15})
    }.height('30%').alignItems(HorizontalAlign.End)
  }


  build() {
    Column() {
      Navigation(this.pageInfos) {

        Column({ space: 12 }) {
          userImage()
          //以上是用户头像昵称部分
          experience()

          Column() {
            List({ space: 12 }) {
              ListItem() {
                Text(this.nameList[0])
                  .width("100%")
                  .height(72)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(24)
                  .fontSize(16)
                  .fontWeight(500)
                  .textAlign(TextAlign.Start)
                  .padding({ left: 20 })
                  .onClick(() => {
                    this.pageInfos.pushPath({ name: this.nameList[0] })
                  })
                  .overlay(this.OverlayNode(), { align: Alignment.End })
              }
            }
            .width("90%")
          }
          .width('100%')
          .height('30%')
          .margin({ top: 12 })
        }
        .height('100%')
        .width('100%')
        .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP])
      }
      .mode(NavigationMode.Stack)
      .navDestination(this.PageMap)
      .hideToolBar(true)
      .height('100%')
      // .toolbarConfiguration([this.TooTmp, this.TooTmp, this.TooTmp])
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f5fbf9')
  }
}

// PageOne.ets
@Component
export struct testResult {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("这是你的测试成绩")
      }.width('100%').height('100%')
    }.title("测试成绩")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageTwo.ets
@Component
export struct changeProfile {
  @State imageUrl: string = 'app.media.person'
  @Consume userName:string
  @Consume signature:string

  @Consume('pageInfos') pageInfos: NavPathStack;

  submit(){
    const req = http.createHttp()
    req.request('https://eqmaster.redamancyxun.fun:8080/user/updateUserInfo', {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'session': PreferenceModel.getPreference("session", '')
      },
      extraData: {
        "username": this.userName,
        "signature": this.signature,
        "gender": 7,
        "age": 31,
        "nation": null,
        "province": "新疆维吾尔自治区",
        "city": "莱芜市"
      }
    },(err:BusinessError,res:http.HttpResponse)=> {
      if (!err) {
        console.log("profile changed successfully")
        console.info('Result:' + JSON.stringify(res.result));
      } else {
        console.info('submit: error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        req.off('headersReceive');
        // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
        req.destroy();
      }
    })
  }


  build() {
    NavDestination() {
      Column() {

        Column({space:5}) { //头像上面
          Text("修改个人信息")
            .Headline()
            .fontColor('#c6d3fa')
          Text('分享一下下面的个人信息,让我们更好的认识你')
            .SecondaryText()
            .fontColor('#c6d3fa')
        }
        .alignItems(HorizontalAlign.Start)
        .height('10%')
        .margin({left:30,top:10})

        Image($r(this.imageUrl))
          .height('25%')
          .borderRadius(24)
            //设置边框
          .padding(3)
          .borderStyle(BorderStyle.Solid)
          .borderColor('#FFFFFF')
          .borderWidth(2)
            //
          .alignSelf(ItemAlign.Center)
          .margin(20)
          .onError(() => {
            console.info('load image fail')
          })

        Column() {
          TextInput({ placeholder: '用户名' ,text: $$this.userName})
            .margin({ top: 10 })
            .placeholderColor('#c6d3fa')
            .showUnderline(true)
            .underlineColor('#FFFFFF')
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          TextInput({ placeholder: '个性签名', text: $$this.signature })
            .margin({ top: 20 })
            .placeholderColor('#c6d3fa')
            .showUnderline(true)
            .underlineColor('#FFFFFF')
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          Button('确认')
            .width('80%')
            .margin({top:150})
            .fontColor('#c6d3fa')
            .backgroundColor('#000000')
            .onClick(()=>{
              this.submit()
            })
        }
        .padding(20)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor('#436eee')
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}