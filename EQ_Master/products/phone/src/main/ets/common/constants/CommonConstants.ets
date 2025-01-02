import NewsTypeModel from '../../viewmodel/NewsTypeModel';

export class CommonConstants{
  /**
   * The text high
   */
  static TEXT_HEIGHT: number = 50;

  /**
   * The text width
   */
  static DEFAULT_MARGIN: number = 30;

  /**
   * Full the width.
   */
  static FULL_WIDTH: string = '100%';

  /**
   * Full the height.
   */
  static FULL_HEIGHT: string = '120%';

  /**
   * Default fontSize
   */
  static DEFAULT_FONT_SIZE: number = 30;

  /*
   * Log Domain
   * */
  static DOMAIN: number = 0x0000;

  /**
   * The main ability tag.
   */
  static readonly ENTRY_ABILITY_TAG: string = 'EntryAbility';

  /**
   * The launcher page tag.
   */
  static readonly LAUNCHER_PAGE_TAG: string = 'LauncherPage';

  /**
   * The advertsing page tag.
   */
  static readonly ADVERTISING_PAGE_TAG: string = 'AdvertisingPage';

  /**
   * The custom dialog component tag.
   */
  static readonly CUSTOM_DIALOG_TAG: string = 'CustomDialogComponent';

  /**
   * Preference saved key.
   */
  static readonly PREFERENCES_KEY_PRIVACY: string = 'isPrivacy';

  /**
   * Preference saved key.
   */
  static readonly PREFERENCES_KEY_FIRST_USER: string = 'isFirstUser';

  /**
   * Preference saved key.
   */
  static readonly PREFERENCES_KEY_SESSION: string = 'session';

  /**
   * Preference saved file name.
   */
  static readonly PREFERENCES_FILE_NAME: string = 'myStore';

  /**
   * Launcher page count down.
   */
  static readonly LAUNCHER_DELAY_TIME: number = 3000;

  /**
   * Image logo top margin.
   */
  static readonly LAUNCHER_IMAGE_MARGIN_TOP: string = '70%';

  /**
   * Healthy living text spacing.
   */
  static readonly LAUNCHER_LIFE_TEXT_SPACING: number = 0.1;

  /**
   * Healthy living title text top margin.
   */
  static readonly LAUNCHER_TEXT_TITLE_MARGIN_TOP: string = '0.5%';

  /**
   * Content control height.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_HEIGHT: string = '2.7%';

  /**
   * Healthy living instructions.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_SPACING: number = 1;

  /**
   * Healthy living content top margin.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_MARGIN_TOP: string = '1.3%';

  /**
   * Interval execution time.
   */
  static readonly ADVERTISING_INTERVAL_TIME: number = 1000;

  /**
   * Advertising page url.
   */
  static readonly ADVERTISING_PAGE_URL: string = 'pages/launcher/AdvertisingPage';

  /**
   * First page url.
   */
  static readonly FIRST_PAGE_URL: string = 'pages/launcher/FirstPage';

  /**
   * Login page url.
   */
  static readonly LOGIN_PAGE_URL: string = 'pages/login/LoginPage';

  /**
   * Display countdown seconds.
   */
  static readonly ADVERTISING_COUNT_DOWN_SECONDS: number = 2;

  /**
   * Count down text spacing.
   */
  static readonly ADVERTISING_TITLE_TEXT_LETTER_SPACING: number = 0.05;

  /**
   * Advertising page healthy text spacing.
   */
  static readonly ADVERTISING_HEALTHY_LIFE_TEXT_SPACING: number = 0.1;

  /**
   * Advertising page health description text spacing.
   */
  static readonly ADVERTISING_TEXT_INTRODUCE_LETTER_SPACING: number = 3.4;

  /**
   * Advertising page health description text top margin.
   */
  static readonly ADVERTISING_TEXT_INTRODUCE_MARGIN_TOP: string = '0.4%';

  /**
   * Column container left margin.
   */
  static readonly ADVERTISING_COLUMN_MARGIN_LEFT: string = '3.1%';

  /**
   * Row container bottom margin.
   */
  static readonly ADVERTISING_ROW_MARGIN_BOTTOM: string = '3.1%';

  /**
   * Dialog component width the percentage of the 90.
   */
  static readonly DIALOG_COMPONENT_WIDTH_PERCENT: string = '90%';

  /**
   * Dialog title text weight.
   */
  static readonly DIALOG_TITLE_FONT_WEIGHT: number = 600;

  /**
   * Dialog width the percentage of the 93.3.
   */
  static readonly DIALOG_WIDTH_PERCENT: string = '93.3%';

  /**
   * Dialog border radius.
   */
  static readonly DIALOG_BORDER_RADIUS: number = 24;

  /**
   * Dialog component bottom margin,
   */
  static readonly DIALOG_ROW_MARGIN_BOTTOM: string = '3.1%';

  /**
   * Dialog y-axis offset distance.
   */
  static readonly DIALOG_CONTROLLER_DY_OFFSET: number = -24;

  /**
   * Privacy page url.
   */
  static readonly PRIVACY_PAGE_URL: string = 'pages/launcher/PrivacyPage';

  /**
   * App home page url.
   */
  static readonly APP_HOME_PAGE_URL: string = 'pages/launcher/AppHomePage';

  /**
   * Common layout weight.
   */
  static readonly COMMON_LAYOUT_WEIGHT: number = 1;

  /**
   * The advertsing page tag.
   */
  static readonly FIRST_PAGE_TAG: string = 'FirstPage';
  /**
   * The advertsing page tag.
   */
  static readonly SECOND_PAGE_TAG: string = 'SecondPage';

  /**
   * The advertsing page tag.
   */
  static readonly THIRD_PAGE_TAG: string = 'ThirdPage';

  /**
   * First page url.
   */
  static readonly First_PAGE_URL: string = 'pages/launcher/FirstPage';

  /**
   * Second page url.
   */
  static readonly Second_PAGE_URL: string = 'pages/launcher/SecondPage';

  /**
   * Third page url.
   */
  static readonly Third_PAGE_URL: string = 'pages/launcher/ThirdPage';

  /**
   * Input length of the account.
   */
  static readonly INPUT_ACCOUNT_LENGTH: number = 11;

  /**
   * Input length of the telephone.
   */
  static readonly INPUT_TELEPHONE_LENGTH: number = 11;

  /**
   * Input length of the password.
   */
  static readonly INPUT_PASSWORD_LENGTH: number = 16;

  /**
   * Left padding of the input box.
   */
  static readonly INPUT_PADDING_LEFT: number = 8;

  /**
   * Delay time of simulated login.
   */
  static readonly LOGIN_DELAY_TIME: number = 2000;

  /**
   * Common Spacing of Components.
   */
  static readonly COMMON_SPACE: number = 12;

  /**
   * Spacing of other login methods.
   */
  static readonly LOGIN_METHODS_SPACE: number = 44;

  /**
   * Prompt duration.
   */
  static readonly PROMPT_DURATION: number = 2000;

  /**
   * User authentication dialog.
   */
  static readonly PROMPT_AUTH_DURATION: number = 1000;

  /**
   * Home tab index.
   */
  static readonly HOME_TAB_INDEX: number = 0;

  /**
   * Mine tab index.
   */
  static readonly MINE_TAB_INDEX: number = 1;

  /**
   * Convert milliseconds to seconds.
   */
  static readonly MILLISECONDS_TO_SECONDS: number = 1;

  /**
   * Grid columns template.
   */
  static readonly HOME_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr 1fr';

  /**
   * Grid rows template.
   */
  static readonly HOME_ROWS_TEMPLATE: string = '1fr 1fr';

  /**
   * Grid columns template.
   */
  static readonly SECOND_COLUMNS_TEMPLATE: string = '1fr 1fr';

  /**
   * Grid rows template.
   */
  static readonly SECOND_ROWS_TEMPLATE: string = '1fr 1fr';

  /**
   * Preferences database name.
   */
  static readonly PREFERENCES_NAME: string = 'eq_master.db';

  /**
   * Logger tag.
   */
  static readonly TAG: string = '[UserAuth]';

  /**
   * Key storage field.
   */
  static readonly KEY: string = 'key';

  /**
   * Password storage field.
   */
  static readonly CRYPTO_PASSWORD: string = 'cryptoPassword';

  /**
   * UserName storage field.
   */
  static readonly USER_NAME: string = 'userName';

  /**
   * Keys alias storage field.
   */
  static readonly LOGIN_KEYS: string = 'loginKeys'

  /**
   * Display face authentication.
   */
  static readonly IS_SHOW_FACE: string = 'isShowFace';

  /**
   * Display fingerprint authentication.
   */
  static readonly IS_SHOW_FINGERPRINT: string = 'isShowFingerprint';

  /**
   * Login page url.
   */
  static readonly ROUTER_LOGIN_URL: string = 'pages/LoginPage';

  /**
   * Register page url.
   */
  static readonly ROUTER_REGISTER_URL: string = 'pages/RegisterPage';

  /**
   * Main page url.
   */
  static readonly ROUTER_MAIN_URL: string = 'pages/MainPage';

  /**
   * Default distance between the prompt and the bottom.
   */
  static readonly PROMPT_BOTTOM: string = '80vp';

  /**
   * The width or height of the component is spread across the parent component.
   */
  static readonly FULL_PARENT: string = '100%';

  /**
   * The width of button.
   */
  static readonly BUTTON_WIDTH: string = '90%';

  /**
   * The host address of the server.
   */
  static readonly SERVER: string = 'https://eqmaster.redamancyxun.fun:8080';

  /**
   * The post user login.
   */
  static readonly POST_USER_LOGIN: string = 'user/login';

  /**
   * The get user check login.
   */
  static readonly GET_USER_CHECKLOGIN: string = 'user/checkLogin';

  /**
   * The post user signup.
   */
  static readonly POST_USER_SIGNUP: string = 'user/signup';

  /**
   * Get the news type.
   */
  static readonly GET_NEWS_TYPE: string = 'news/getNewsType';

  /**
   * Get the news list.
   */
  static readonly GET_NEWS_LIST: string = 'news/getNewsList';

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;

  /**
   * The off set coefficient.
   */
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 4;

  /**
   * The refresh and load height.
   */
  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The animation delay time.
   */
  static readonly DELAY_ANIMATION_DURATION: number = 300;

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;


  /**
   * The TabBars constants.
   */
  static readonly TabBars_UN_SELECT_TEXT_FONT_SIZE: number = 18;
  static readonly TabBars_SELECT_TEXT_FONT_SIZE: number = 24;
  static readonly TabBars_UN_SELECT_TEXT_FONT_WEIGHT: number = 400;
  static readonly TabBars_SELECT_TEXT_FONT_WEIGHT: number = 700;
  static readonly TabBars_BAR_HEIGHT: string = '7.2%';
  static readonly TabBars_HORIZONTAL_PADDING: string  = '2.2%';
  static readonly TabBars_BAR_WIDTH: string = '100%';
  static readonly TabBars_DEFAULT_NEWS_TYPES: Array<NewsTypeModel> = [
    { id: 0, name: '全部' },
    { id: 1, name: '国内' },
    { id: 2, name: '国际' },
    { id: 3, name: '娱乐' },
    { id: 4, name: '军事' },
    { id: 5, name: '体育' },
    { id: 6, name: '科技' },
    { id: 7, name: '财经' }
  ];

  /**
   * The NewsListConstant constants.
   */
  static readonly NewsListConstant_LIST_DIVIDER_STROKE_WIDTH: number = 0.5;
  static readonly NewsListConstant_GET_TAB_DATA_TYPE_ONE: number = 1;
  static readonly NewsListConstant_ITEM_BORDER_RADIUS: number = 16;
  static readonly NewsListConstant_NONE_IMAGE_SIZE: number = 120;
  static readonly NewsListConstant_NONE_TEXT_opacity: number = 0.6;
  static readonly NewsListConstant_NONE_TEXT_size: number = 16;
  static readonly NewsListConstant_NONE_TEXT_margin: number = 12;
  static readonly NewsListConstant_ITEM_MARGIN_TOP: string = '1.5%';
  static readonly NewsListConstant_LIST_MARGIN_LEFT: string = '3.3%';
  static readonly NewsListConstant_LIST_MARGIN_RIGHT: string = '3.3%';
  static readonly NewsListConstant_ITEM_HEIGHT: string = '32%';
  static readonly NewsListConstant_LIST_WIDTH: string =  '93.3%';

  /**
   * The NewsTitle constants.
   */
  static readonly NewsTitle_TEXT_MAX_LINES: number = 3;
  static readonly NewsTitle_TEXT_FONT_SIZE: number = 20;
  static readonly NewsTitle_TEXT_FONT_WEIGHT: number = 500;
  static readonly NewsTitle_TEXT_MARGIN_LEFT: string = '2.4%';
  static readonly NewsTitle_TEXT_MARGIN_TOP: string = '7.2%';
  static readonly NewsTitle_TEXT_HEIGHT: string = '9.6%';
  static readonly NewsTitle_TEXT_WIDTH: string = '78.6%';
  static readonly NewsTitle_IMAGE_MARGIN_LEFT: string = '3.5%';
  static readonly NewsTitle_IMAGE_MARGIN_TOP: string = '7.9%';
  static readonly NewsTitle_IMAGE_HEIGHT: string = '8.9%';
  static readonly NewsTitle_IMAGE_WIDTH: string = '11.9%';

  /**
   * The NewsContent constants.
   */
  static readonly NewsContent_WIDTH: string = '93%';
  static readonly NewsContent_HEIGHT: string = '16.8%';
  static readonly NewsContent_MARGIN_LEFT: string = '3.5%';
  static readonly NewsContent_MARGIN_TOP: string = '3.4%';
  static readonly NewsContent_MAX_LINES: number = 2;
  static readonly NewsContent_FONT_SIZE: number = 15;

  /**
   * The NewsSource constants.
   */
  static readonly NewsSource_MAX_LINES: number = 1;
  static readonly NewsSource_FONT_SIZE: number = 12;
  static readonly NewsSource_MARGIN_LEFT: string = '3.5%';
  static readonly NewsSource_MARGIN_TOP: string = '3.4%';
  static readonly NewsSource_HEIGHT: string = '7.2%';
  static readonly NewsSource_WIDTH: string = '93%';

  /**
   * The NewsGrid constants.
   */
  static readonly NewsGrid_MARGIN_LEFT: string = '3.5%';
  static readonly NewsGrid_MARGIN_RIGHT: string = '3.5%';
  static readonly NewsGrid_MARGIN_TOP: string = '5.1%';
  static readonly NewsGrid_WIDTH: string = '93%';
  static readonly NewsGrid_HEIGHT: string = '31.5%';
  static readonly NewsGrid_ASPECT_RATIO: number = 4;
  static readonly NewsGrid_COLUMNS_GAP: number = 5;
  static readonly NewsGrid_ROWS_TEMPLATE: string = '1fr';
  static readonly NewsGrid_IMAGE_BORDER_RADIUS: number = 8;

  /**
   * The RefreshLayout constants.
   */
  static readonly RefreshLayout_MARGIN_LEFT: string = '40%';
  static readonly RefreshLayout_TEXT_MARGIN_BOTTOM: number = 1;
  static readonly RefreshLayout_TEXT_MARGIN_LEFT: number = 7;
  static readonly RefreshLayout_TEXT_FONT_SIZE: number = 17;
  static readonly RefreshLayout_IMAGE_WIDTH: number = 18;
  static readonly RefreshLayout_IMAGE_HEIGHT: number = 18;

  /**
   * The NoMoreLayout constants.
   */
  static readonly NoMoreLayoutConstant_NORMAL_PADDING: number = 8;
  static readonly NoMoreLayoutConstant_TITLE_FONT: string = '16fp';

  /**
   * The RefreshConstant constants.
   */
  static readonly RefreshConstant_DELAY_PULL_DOWN_REFRESH: number = 50;
  static readonly RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME: number = 150;
  static readonly RefreshConstant_DELAY_SHRINK_ANIMATION_TIME: number = 500;
}

/**
 * The refresh state enum.
 */
export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}

/**
 * The newsList state enum.
 */
export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}

/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json'
}