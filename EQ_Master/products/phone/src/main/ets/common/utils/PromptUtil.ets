/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

import { CommonConstants } from '../constants/CommonConstants';
import { promptAction } from '@kit.ArkUI';

/**
 * Prompt util
 */
class PromptUtil {
  /**
   * A dialog box is displayed.
   * @param message
   * @param time
   * @param bottom
   */
  promptMessage(message: string | Resource, time: number, bottom: string | number = CommonConstants.PROMPT_BOTTOM) {
    promptAction.showToast({
      message:message,
      duration: time,
      bottom: bottom
    })
  }
}

export default new PromptUtil();