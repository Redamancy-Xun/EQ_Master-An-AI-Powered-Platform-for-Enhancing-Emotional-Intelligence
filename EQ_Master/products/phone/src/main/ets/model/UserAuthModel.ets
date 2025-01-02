/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

import { userAuth } from '@kit.UserAuthenticationKit'
import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';

class UserAuthModel {
  /**
   * User authentication object.
   */
  private userAuth?: userAuth.UserAuthInstance;

  /**
   * Check whether the capability is supported.
   *
   * @param type UserAuthType.
   */
  queryAvailable(type: userAuth.UserAuthType): boolean {
    let isAvailable: boolean = false;
    if (!type) {
      return false;
    }
    try {
      userAuth.getAvailableStatus(type, userAuth.AuthTrustLevel.ATL1);
      isAvailable = true;
    } catch (error) {
      Logger.error(CommonConstants.TAG, `auth trust level is not supported cause ${error.code} ${error.message}`);
      isAvailable = false;
    }
    return isAvailable;
  }

  /**
   * Queries whether facial recognition is supported.
   */
  isFaceAvailable(): boolean {
    return this.queryAvailable(userAuth.UserAuthType.FACE)
  }

  /**
   * Querying whether fingerprint recognition is support.
   */
  isFingerprintAvailable(): boolean {
    return this.queryAvailable(userAuth.UserAuthType.FINGERPRINT);
  }

  /**
   * Obtains a facial recognition object.
   */
  getFaceAuth(callback: (isSuccess: boolean) => void) {
    if (!callback) {
      return;
    }
    let authType = userAuth.UserAuthType.FACE;
    let authTrustLevel = userAuth.AuthTrustLevel.ATL1;
    this.getAuth(authType, authTrustLevel, callback);
  }

  /**
   * Obtaining a fingerprint recognition object.
   */
  getFingerprintAuth(callback: (isSuccess: boolean) => void) {
    if (!callback) {
      return;
    }
    let authType = userAuth.UserAuthType.FINGERPRINT;
    let authTrustLevel = userAuth.AuthTrustLevel.ATL1;
    this.getAuth(authType, authTrustLevel, callback);
  }

  /**
   * Obtains the user authentication object.
   *
   * @param authType UserAuthType
   * @param authTrustLevel AuthTrustLevel
   */
  getAuth(authType: userAuth.UserAuthType, authTrustLevel: userAuth.AuthTrustLevel, callback: (isSuccess: boolean) => void) {
    // 设置认证参数
    const authParam: userAuth.AuthParam = {
      challenge: new Uint8Array([49, 49, 49, 49, 49, 49]),
      authType: [authType],
      authTrustLevel: authTrustLevel,
    }
    // 配置认证界面
    const widgetParam: userAuth.WidgetParam = {
      title: '请进行身份认证',
    };

    try {
      this.userAuth = userAuth.getUserAuthInstance(authParam, widgetParam);
      this.userAuth.on('result', {
        onResult(result) {
          console.info(`userAuthInstance callback result: ${JSON.stringify(result)}`);
          if (result.result === userAuth.UserAuthResultCode.SUCCESS) {
            callback(true);
          }
        }
      });
    } catch (error) {
      Logger.error(CommonConstants.TAG, `get auth instance failed cause ${error.code} ${error.message}`);
    }
  }

  /**
   * Convert milliseconds to seconds.
   *
   * @param milliseconds Milliseconds.
   */
  convertToSeconds(milliseconds: number): number {
    return Math.ceil(milliseconds / CommonConstants.MILLISECONDS_TO_SECONDS);
  }

  /**
   * Start authentication.
   */
  start() {
    if (!this.userAuth) {
      Logger.error(CommonConstants.TAG, `userAuth is undefined`);
      return;
    }
    try {
      this.userAuth.start();
    } catch (error) {
      Logger.error(CommonConstants.TAG, `authV9 start auth failed, error ${error.code} ${error.message}`);
    }
  }

  /**
   * Cancel authentication
   */
  cancel() {
    if (!this.userAuth) {
      Logger.error(CommonConstants.TAG, `userAuth is undefined`);
      return;
    }
    try {
      this.userAuth.cancel();
    } catch (error) {
      Logger.error(CommonConstants.TAG, `cancel auth failed ${error.code} ${error.message}`);
    }
  }
}

export default new UserAuthModel();