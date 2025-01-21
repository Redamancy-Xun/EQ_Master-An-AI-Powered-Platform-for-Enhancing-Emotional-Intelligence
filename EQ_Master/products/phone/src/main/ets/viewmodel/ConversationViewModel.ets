import { Want, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Logger from '../common/utils/Logger';

interface ConversationDataInterface {
  name: Resource
  msg: Resource
  time: ResourceStr
  icon: Resource
};

const ConversationListData: ConversationDataInterface[] = [
  { name: $r('app.string.Alan'), msg: $r('app.string.okay'), time: '13:55', icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.CaiLan'), msg: $r('app.string.okay'), time: '13:55', icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.FenFen'), msg: $r('app.string.okay'), time: '12:00', icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.FenFen'), msg: $r('app.string.okay'), time: '08:00', icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.FanYi'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.Deng'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.CaiLan'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.Alan'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.Alan'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.FanYi'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.Deng'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
  { name: $r('app.string.ge'), msg: $r('app.string.okay'), time: $r('app.string.yesterday'), icon: $r('app.media.EQ_Master_start_icon') },
];

class ConversationViewModel {
  public startAppletAbility(context: common.UIAbilityContext, index: number): void {
    const want: Want = {
      bundleName: getContext(context).applicationInfo.name,
      abilityName: 'AppletAbility',
      parameters: {
        position: index
      }
    };
    try {
      context.startAbility(want, (err: BusinessError) => {
        if (err.code) {
          Logger.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (error) {
      hilog.error(0x00004, 'ConversationViewModel', '%{public}s', error);
    }
  }

  public startDocumentAbility(context: common.UIAbilityContext, index: number): void {
    const want: Want = {
      bundleName: getContext(context).applicationInfo.name,
      abilityName: 'DocumentAbility',
      parameters: {
        position: index
      }
    };
    try {
      context.startAbility(want, (err: BusinessError) => {
        if (err.code) {
          Logger.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (error) {
      Logger.error(`startAbility failed,  message is ${error}`);
    }
  }
}

export { ConversationDataInterface, ConversationListData, ConversationViewModel };