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
