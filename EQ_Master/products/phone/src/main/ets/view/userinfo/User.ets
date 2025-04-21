interface Result{
  id: string;
  username: string;
  telephone: string;
  portrait: string;
  signature: string;
  likeCount: number;
  commentCount: number;
  gender: number;  // 2 represents male, 1 represents female, -1 represents unspecified or other
  age: number;     // -1 indicates age is unspecified
  role: number;    // Role ID (e.g., 3 could represent admin, 2 could represent user, etc.)
  nation: string;
  province: string;
  city: string;
  sessionId: string;
  testScoreHistory: string;  // Could be a list of scores, null if no data
  eqhistory: string;        // Could be a list or null if no data
}

export interface userInfo{
  code:number,
  message:string,
  result:Result
}


export class CommonData {

  static readonly gender: string[] = [
    'Unknown','男','女'
  ];

  static readonly jobList: string[] = [
    "上班族", "学生", "自由职业者", "企业家/创业者", "公务员/事业单位工作人员"
  ];


  static readonly workPeopleList: string[] = [
    "上级", "下级", "同事", "客户", "老师", "同学"
  ];


  static readonly lifePeopleList: string[] = [
    "子女、其他后辈", "父母、其他长辈", "兄弟/姐妹", "伴侣", "朋友", "陌生人"
  ];
}
