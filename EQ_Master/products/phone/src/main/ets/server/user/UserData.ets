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
   * User role.
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

}