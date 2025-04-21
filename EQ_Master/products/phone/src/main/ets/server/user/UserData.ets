import { EmotionalIntelligence } from '../emotionalintelligence/EQData';
import ResponseResult from '../ResponseResult';
import { TestScore } from '../test/TestData';

export class UserInfo {

  /**
   * User ID.
   */
  id: string | null = null;

  /**
   * Username.
   */
  username: string | null = null;

  /**
   * Telephone number.
   */
  telephone: string | null = null;

  /**
   * Portrait image URL.
   */
  portrait: string | null = null;

  /**
   * User signature.
   */
  signature: string | null = null;

  /**
   * Like count.
   */
  likeCount: number | null = null;

  /**
   * Comment count.
   */
  commentCount: number | null = null;

  /**
   * Gender (0 for unknown, 1 for male, 2 for female).
   */
  gender: number | null = null;

  /**
   * Age.
   */
  age: number | null = null;

  /**
   * User role.  0--"上班族", 1--"学生", 2--"自由职业者", 3--"企业家/创业者", 4--"公务员/事业单位工作人员"
   */
  role: number | null = null;

  /**
   * Nationality.
   */
  nation: string | null = null;

  /**
   * Province.
   */
  province: string | null = null;

  /**
   * City.
   */
  city: string | null = null;

  /**
   * Session ID.
   */
  sessionId: string | null = null;

  /**
   * Test score history.
   */
  testScoreHistory: Array<TestScore> | null = null;

  /**
   * EQ history.
   */
  eqhistory: Array<EmotionalIntelligence> | null = null;

  /**
   * People List in Work  0--"上级", 1--"下级", 2--"同事", 3--"客户", 4--"老师", 5--"同学"
   */
  peopleInWork: number[] |null = null;
  /**
   * People List in Life  0--"子女、其他后辈", 1--"父母、其他长辈", 2--"兄弟/姐妹", 3--"伴侣", 4--"朋友", 5--"陌生人"
   */
  peopleInLife: number[] |null = null;


}