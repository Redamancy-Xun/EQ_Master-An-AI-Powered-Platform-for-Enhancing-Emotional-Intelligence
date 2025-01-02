/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

import { preferences } from '@kit.ArkData'
import { CommonConstants } from '../common/constants/CommonConstants';
import { common } from '@kit.AbilityKit';

let context = getContext(this) as common.UIAbilityContext;

class PreferenceModel {
  private preference?: preferences.Preferences;

  /**
   * Read the specified Preferences persistence file and load the data into the Preferences instance.
   */
  getPreferencesFromStorage(): preferences.Preferences {
    if (!this.preference) {
      let options: preferences.Options = { name: CommonConstants.PREFERENCES_NAME};
      this.preference = preferences.getPreferencesSync(context, options);
    }
    return this.preference;
  }

  /**
   * Save the data to the Preferences.
   *
   * @param key Key.
   * @param Data to be saved.
   */
  putPreference(key: string, value: preferences.ValueType) {
    let preference = this.getPreferencesFromStorage();
    if (!key || !value) {
      return;
    }
    preference.putSync(key, value);
    preference.flush();
  }

  /**
   * Get preference data.
   *
   * @param key Key.
   * @param value Default value.
   */
  getPreference(key: string, value: preferences.ValueType): preferences.ValueType {
    let preference = this.getPreferencesFromStorage();
    return preference.getSync(key, value);
  }
}

export default new PreferenceModel();