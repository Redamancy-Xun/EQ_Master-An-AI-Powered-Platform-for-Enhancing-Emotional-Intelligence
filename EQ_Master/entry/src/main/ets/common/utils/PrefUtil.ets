import preferences from '@ohos.data.preferences';

const STORE_NAME = "baseInfo";
const KEY_APP_CONTEXT = "CONTEXT";

let preference: preferences.Preferences;
let context = getContext(this)

class PreferenceUtil {
  // 初始化对象
  async getPreferencesFromStorage() {
    try {
      preference = await preferences.getPreferences(context, STORE_NAME)
    }
    catch (err) {
      console.error(`error:${err}`)
    }
  }

  /**
   * 删除所有的preferences对象
   */
  async deletePreferences() {
    try {
      await preferences.deletePreferences(context, STORE_NAME);
    } catch(err) {
      console.error('TAG', `Failed to delete preferences, Cause: ${err}`);
    };
  }

  // 写入preference数据
  async putPreference(context : string) {
    if (!preference) {
      await this.getPreferencesFromStorage();
    }
    // 将数据保存到首选项，内存中
    try {
      await preference.put(KEY_APP_CONTEXT,context);
    } catch (err) {
      console.error('TAG', `Failed to put value, Cause: ${err}`);
    }
    // 【数据持久化，写入文件】Store the Preference instance in the preference persistence file
    await preference.flush();
  }

  /**
   * 获取preference对象
   */
  async getPreference() {
    let context: string = '';

    try {
      context = (await preference.get(KEY_APP_CONTEXT,context)).toString()
    } catch (err) {
      console.error('TAG', `Failed to get value, Cause: ${err}`)
    }

    return context;

  }
}

export default new PreferenceUtil();