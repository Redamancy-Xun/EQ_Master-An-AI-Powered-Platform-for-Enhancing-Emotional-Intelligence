/**
 * Data returned by the network request.
 */
export default class ResponseResult {
  /**
   * Code returned by the network request.
   */
  code: number | null;

  /**
   * Message returned by the network request.
   */
  message: string | Resource | null;

  /**
   * Data returned by the network request.
   */
  result: Object | null;

  constructor() {
    this.code = null;
    this.message = null;
    this.result = null;
  }
}