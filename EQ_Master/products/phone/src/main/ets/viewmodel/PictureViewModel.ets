import { PictureItem } from './PictureItem';
import {PICTURE_LATEST, PICTURE_BANNER, PICTURE_MAP } from '../common/constants/PictureConstants';
import { PictureType } from '../common/constants/PictureConstants';
import { CommonConstants } from '../common/constants/CommonConstants';
import { DailyShare } from '../server/dailyshare/DailyShareData';
import { DailyShareItem } from '../common/constants/DailyShareList';

/**
 * Initialize picture data according to type.
 *
 * @param initType Init type.
 */
export function initializePictures(initType: string, initDailyShare?: Array<DailyShareItem>): Array<PictureItem> {
  let imageDataArray: Array<PictureItem> = [];
  switch (initType) {
    case PictureType.BANNER:
      PICTURE_BANNER.forEach((item: PictureItem) => {
        imageDataArray.push(item);
      })
      break;
    case PictureType.QUESTION:
      if (initDailyShare === undefined) {
        return [];
      }
      initDailyShare.forEach((dailyShare: DailyShareItem) => {
        let item: PictureItem = new PictureItem();
        if (dailyShare.id !== null) {
          item.id = dailyShare.id;
        }
        if (dailyShare.title !== null) {
          item.name = dailyShare.title;
        }
        if (dailyShare.context !== null) {
          item.description = dailyShare.context;
        }
        if (dailyShare.picture !== null) {
          item.image = PICTURE_MAP.get(dailyShare.picture);
        }
        imageDataArray.push(item);
      })
      break;
    case PictureType.TIP:
      if (initDailyShare === undefined) {
        return [];
      }
      initDailyShare.forEach((dailyShare: DailyShareItem) => {
        let item: PictureItem = new PictureItem();
        if (dailyShare.id !== null) {
          item.id = dailyShare.id;
        }
        if (dailyShare.title !== null) {
          item.name = dailyShare.title;
        }
        if (dailyShare.context !== null) {
          item.description = dailyShare.context;
        }
        if (dailyShare.picture !== null) {
          item.image = PICTURE_MAP.get(dailyShare.picture);
        }
        imageDataArray.push(item);
      })
    case PictureType.STORY:
      if (initDailyShare === undefined) {
        return [];
      }
      initDailyShare.forEach((dailyShare: DailyShareItem) => {
        let item: PictureItem = new PictureItem();
        if (dailyShare.id !== null) {
          item.id = dailyShare.id;
        }
        if (dailyShare.title !== null) {
          item.name = dailyShare.title;
        }
        if (dailyShare.context !== null) {
          item.description = dailyShare.context;
        }
        if (dailyShare.picture !== null) {
          item.image = PICTURE_MAP.get(dailyShare.picture);
        }
        imageDataArray.push(item);
      })
    default:
      break;
  }
  return imageDataArray;
}

let timerIds: number[] = [];

/**
 * start scheduled task.
 *
 * @param swiperController Controller.
 */
export function startPlay(swiperController: SwiperController): void {
  let timerId = setInterval(() => {
    swiperController.showNext();
  }, CommonConstants.SWIPER_TIME);
  timerIds.push(timerId);
}

/**
 * stop scheduled task.
 */
export function stopPlay(): void {
  timerIds.forEach((item: number) => {
    clearTimeout(item);
  })
}