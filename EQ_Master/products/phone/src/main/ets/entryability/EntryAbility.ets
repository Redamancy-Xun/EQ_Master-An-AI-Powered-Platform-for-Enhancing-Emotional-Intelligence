import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  windowStage: window.WindowStage | undefined = undefined;
  tag: string = 'EntryAbility';
  domain: number = 0x0000;
  want: Want | undefined = undefined;
  launchParam: AbilityConstant.LaunchParam | undefined = undefined;
  windowStageEventFunc: (data: window.WindowStageEventType) => void = (data: window.WindowStageEventType): void => {
    hilog.info(
      this.domain,
      'Succeeded in enabling the listener for window stage event changes. Data: %{public}',
      JSON.stringify(data) ?? ''
    );
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.want = want;
    this.launchParam = launchParam;
    hilog.info(this.domain, this.tag, 'Ability is onCreate.');
  }

  onDestroy(): void {
    hilog.info(this.domain, this.tag, 'Ability is onDestroy.');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    // // 设置WindowStage的事件订阅（获焦/失焦、切到前台/切到后台、前台可交互/前台不可交互）
    // try {
    //   windowStage.on('windowStageEvent', (data) => {
    //     let stageEventType: window.WindowStageEventType = data;
    //     switch (stageEventType) {
    //       case window.WindowStageEventType.SHOWN: // 切到前台
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage foreground.`);
    //         break;
    //       case window.WindowStageEventType.ACTIVE: // 获焦状态
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage active.`);
    //         break;
    //       case window.WindowStageEventType.INACTIVE: // 失焦状态
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage inactive.`);
    //         break;
    //       case window.WindowStageEventType.HIDDEN: // 切到后台
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage background.`);
    //         break;
    //       case window.WindowStageEventType.RESUMED: // 前台可交互状态
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage resumed.`);
    //         break;
    //       case window.WindowStageEventType.PAUSED: // 前台不可交互状态
    //         hilog.info(DOMAIN_NUMBER, TAG, `windowStage paused.`);
    //         break;
    //       default:
    //         break;
    //     }
    //   });
    // } catch (exception) {
    //   hilog.error(DOMAIN_NUMBER, TAG,
    //     `Failed to enable the listener for window stage event changes. Cause: ${JSON.stringify(exception)}`);
    // }
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    //
    // windowStage.loadContent('pages/Index', (err) => {
    //   if (err.code) {
    //     hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
    //     return;
    //   }
    //   hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    // });

    this.windowStage = windowStage;

    // Setting Event Subscription for WindowStage (Obtained/Out-of-focus, Visible/Invisible)
    try {
      windowStage.on('windowStageEvent', this.windowStageEventFunc);
    } catch (exception) {
      hilog.error(
        this.domain,
        'Failed to enable the listener for window stage event changes. Cause: %{public}',
        JSON.stringify(exception) ?? ''
      );
    }

    // Main window is created, set main page for this ability
    // Setting UI Loading
    windowStage.loadContent('pages/launcher/LauncherPage', (err, data) => {
      if (err.code) {
        hilog.error(this.domain, 'testTag', 'Failed to load the content. Cause: %{public}s',
          JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(this.domain, this.tag, 'Succeeded in loading the content. Data: %{public}s',
        JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // // Main window is destroyed, release UI related resources
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    // Releasing UI Resources
    // Unregisters the WindowStage event for getting/out of focus in onWindowStageDestroy()
    try {
      this.windowStage?.off('windowStageEvent');
    } catch (exception) {
      hilog.error(this.domain, 'Failed to disable the listener for window stage event changes. Cause: %{public}s',
        JSON.stringify(exception));
    }
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(this.domain, this.tag, 'Ability is onForeground.');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(this.domain, this.tag, 'Ability is onBackground.');
  }
}
