import NewsTypeModel from '../../viewmodel/NewsTypeModel';

export class CommonConstants{
  /**
   * Half percent.
   */
  static readonly HALF_PERCENT: string = '50%';

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
  static FULL_WIDTH = '100%';

  /**
   * Full the height.
   */
  static readonly FULL_HEIGHT = '120%';

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
  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

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
  static readonly APP_HOME_PAGE_URL: string = 'pages/HomePage';

  /**
   * Common layout weight.
   */
  static readonly COMMON_LAYOUT_WEIGHT: number = 1;


  /**
   * The advertsing page tag.
   */
  static readonly  DAILYSHARING_PAGE_TAG: string = 'DailysharingPage';
  /**
   * The advertsing page tag.
   */
  static readonly EQAIASSISTANT_PAGE_TAG: string = 'EQIAassistantPage';
  /**
   * The advertsing page tag.
   */
  static readonly CBTTRAINING_PAGE_TAG: string = 'CBTTraingPage';
  /**
   * The advertsing page tag.
   */
  static readonly EQTESTING_PAGE_TAG: string = 'EQTestingPage';
  /**
   * The advertsing page tag.
   */
  static readonly PROFILE_PAGE_TAG: string = 'ProfilePage';


  /**
   * App home page tag.
   */
  static readonly APP_HOME_PAGE_TAG: string = 'HomePage';

  /**
   * The dailyShare page tag.
   */
  static readonly DAILY_SHARE_PAGE_TAG: string = 'DailySharePage';

  /**
   * Third page url.
   */
  static readonly DAILYSHARING_PAGE_URL: string = 'pages/launcher/DailySharingPage';
  /**
   * Third page url.
   */
  static readonly EQAIASSISTANT_PAGE_URL: string = 'pages/launcher/EQAIassistantPage';
  /**
   * Third page url.
   */
  static readonly CBTTRAING_PAGE_URL: string = 'pages/launcher/CBTTrainingPage';
  /**
   * Third page url.
   */
  static readonly EQTESTING_PAGE_URL: string = 'pages/launcher/EQTestingPage';
  /**
   * Third page url.
   */
  static readonly PROFILE_PAGE_URL: string = 'pages/launcher/ProfilePage';


  /**
   * Daily share page url.
   */
  static readonly DAILY_SHARE_TYPE_PAGE_URL: string = 'pages/dailyshare/DailyShareTypeShow';

  /**
   * Daily share page url.
   */
  static readonly DAILY_SHARE_TYPE_PAGE_TAG: string = 'DailyShareTypeShow';

  /**
   * Daily share page url.
   */
  static readonly DAILY_SHARE_DETAIL_PAGE_URL: string = 'pages/dailyshare/DailyShareDetailShow';

  /**
   * Daily share page url.
   */
  static readonly DAILY_SHARE_DETAIL_PAGE_TAG: string = 'DailyShareDetailShow';

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
   * Daily share tab index.
   */
  static readonly HOME_TAB_INDEX: number = 0;

  /**
   * AIChat tab index.
   */
  static readonly AICHAT_TAB_INDEX: number = 1;

  /**
   * Test tab index.
   */
  static readonly TEST_TAB_INDEX: number = 2;

  /**
   * Mine tab index.
   */
  static readonly MINE_TAB_INDEX: number = 3;

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
   * Display selected Job.
   */
  static readonly SELECTED_JOB: string = 'selectedJob';

  /**
   * Display selected People in work.
   */
  static readonly SELECTED_PEOPLE_IN_WORK: string = 'selectedPeopleInWork';
  /**
   * Display selected People in life.
   */
  static readonly SELECTED_PEOPLE_IN_LIFE: string = 'selectedPeopleInLife';

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
   * The width or height of the component is spread across the parent component.
   */
  static readonly EIGHTY_PERCENT_PARENT: string = '80%';

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
   * The get user info.
   */
  static readonly GET_USER_INFO: string = 'user/getUserInfo';

  /**
   * The get user check login.
   */
  static readonly GET_USER_CHECK_LOGIN: string = 'user/checkLogin';

  /**
   * The get ai chat.
   */
  static readonly GET_AI_CHAT: string = 'aichat/aichat';

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
   * Full percent.
   */
  public static readonly FULL_PERCENT: string = '100%';

  /**
   * Ninety percent.
   */
  public static readonly NINETY_PERCENT: string = '90%';

  /**
   * Common zero.
   */
  public static readonly ZERO: number = 0;

  /**
   * Font weight 500.
   */
  public static readonly FONT_WEIGHT_500: number = 500;

  /**
   * Font weight 400.
   */
  public static readonly FONT_WEIGHT_400: number = 400;

  /**
   * Maximum number of lines of text.
   */
  public static readonly MAX_LINES: number = 3;

  /**
   * Indicates the maximum number of addresses returned by reverse geocoding query..
   */
  public static readonly MAX_ITEMS: number = 1;

  /**
   * Layout weight.
   */
  public static readonly LAYOUT_WEIGHT: number = 1;

  /**
   * ListItem space.
   */
  public static readonly LIST_ITEM_SPACE: number = 14;

  /**
   * List space.
   */
  public static readonly LIST_SPACE: number = 3;

  /**
   * AlphabetIndexer itemSize.
   */
  public static readonly ITEM_SIZE: number = 20;

  /**
   * Text opacity.
   */
  public static readonly TEXT_OPACITY: number[] = [1, 0.4, 0.6, 0.05];

  /**
   * Device types.
   */
  public static readonly DEVICE_TYPES: string[] = ['2in1', 'tablet'];

  /**
   * Tab bar height for sm and md.
   */
  public static readonly TAB_BAR_HEIGHT: number = 35;

  /**
   * animation duration of tab content switching.
   */
  static readonly DURATION_PAGE = 50;

  /**
   * animation duration of tab content switching.
   */
  static readonly DURATION_ADS = 200;

  /**
   * height of head portrait.
   */
  static readonly HEIGHT_HEAD = 40;

  /**
   * height of carousel title.
   */
  static readonly HEIGHT_CAROUSEL_TITLE = 90;

  /**
   * fontSize of description.
   */
  static readonly FONT_SIZE_DESCRIPTION = 12;

  /**
   * font size of photo name.
   */
  static readonly FONT_SIZE_PHOTO_NAME = 14;

  /**
   * font size of sort title.
   */
  static readonly FONT_SIZE_SORT_TITLE = 16;

  /**
   * font size of unchecked title.
   */
  static readonly FONT_SIZE_UNCHECKED = 18;

  /**
   * font size of title.
   */
  static readonly FONT_SIZE_TITLE = 20;

  /**
   * font size of checked title.
   */
  static readonly FONT_SIZE_CHECKED = 24;

  /**
   * font size of tab page which content has only tab name.
   */
  static readonly FONT_SIZE_PAGE_CONTENT = 28;

  /**
   * thinner font.
   */
  static readonly FONT_WEIGHT_LIGHT = 400;

  /**
   * normal font.
   */
  static readonly FONT_WEIGHT_NORMAL = 500;

  /**
   * bold font.
   */
  static readonly FONT_WEIGHT_BOLD = 700;

  /**
   * border angle.
   */
  static readonly BORDER_RADIUS = 12;

  /**
   * line height for more.
   */
  static readonly LINE_HEIGHT_MORE = 19;

  /**
   * line height for navigation.
   */
  static readonly LINE_HEIGHT_NAVIGATION = 28;

  /**
   * space of topBar.
   */
  static readonly SPACE_TOP_BAR = 16;

  /**
   * space of navigation.
   */
  static readonly SPACE_NAVIGATION = 8;

  /**
   * border width of head portrait.
   */
  static readonly WIDTH_HEAD_BORDER = 2;

  /**
   * width of head portrait.
   */
  static readonly WIDTH_HEAD = 40;

  /**
   * radius of head portrait.
   */
  static readonly RADIUS_HEAD = 20;

  /**
   * rolling duration.
   */
  static readonly SWIPER_TIME = 3300;

  /**
   * margin of play page.
   */
  static readonly MARGIN_PLAY_PAGE = 10;

  /**
   * margin of text bottom.
   */
  static readonly BOTTOM_TEXT = 4;

  /**
   * margin of banner top.
   */
  static readonly TOP_ADS = 12;

  /**
   * margin of navigation left.
   */
  static readonly LEFT_POSITION = '3%';

  /**
   * margin of banner left.
   */
  static readonly ADS_LEFT = 12;

  /**
   * top margin of picture name.
   */
  static readonly TOP_NAME = 8;

  /**
   * top margin of picture description.
   */
  static readonly TOP_DESCRIPTION = 4;

  /**
   * top margin of vote icon.
   */
  static readonly TOP_IMAGE_VOTE = 20;

  /**
   * top margin of head portrait.
   */
  static readonly TOP_HEAD = 40;

  /**
   * width of play model.
   */
  static readonly WIDTH_PLAY = '95%';

  /**
   * width of tab page.
   */
  static readonly PAGE_WIDTH = '94.4%';

  /**
   * width of sort name.
   */
  static readonly WIDTH_SORT_NAME = '62.2%';

  /**
   * sort content width of all.
   */
  static readonly WIDTH_SORT = '92%';

  /**
   * sort content width of movie.
   */
  static readonly WIDTH_MOVIE_SORT = '90%';

  /**
   * height of picture.
   */
  static readonly HEIGHT_PICTURE = '72%';

  /**
   * height of banner.
   */
  static readonly HEIGHT_BANNER = '30%';

  /**
   * width of vote icon.
   */
  static readonly WIDTH_VOTE = '8.9%';

  /**
   * width of back icon.
   */
  static readonly WIDTH_BACK_ICON = '6.7%';

  /**
   * top margin of sort.
   */
  static readonly MARGIN_TOP_SORT = '3.2%';

  /**
   * bottom margin of sort.
   */
  static readonly MARGIN_BOTTOM_SORT = '2.7%';

  /**
   * bottom margin of grid.
   */
  static readonly MARGIN_BOTTOM_GRID = '4.2%';

  /**
   * height of video.
   */
  static readonly WIDTH_VIDEO = '26.2%';

  /**
   * number of columns.
   */
  static readonly TWO_COLUMNS = '1fr 1fr';

  /**
   * number of rows.
   */
  static readonly TWO_ROWS = '1fr 1fr';

  /**
   * number of columns.
   */
  static readonly THREE_COLUMNS = '1fr 1fr 1fr';

  /**
   * number of rows.
   */
  static readonly THREE_ROWS = '1fr 1fr 1fr';

  /**
   * gap of columns.
   */
  static readonly GAP_COLUMNS = '2.2%';

  /**
   * height of grid.
   */
  static readonly HEIGHT_GRID = '45%';

  /**
   * height of movie description.
   */
  static readonly HEIGHT_DESCRIPTION = '12.3%';

  /**
   * height of top bar.
   */
  static readonly TOP_BAR_HEIGHT = '7.2%';

  /**
   * height of comment icon.
   */
  static readonly HEIGHT_COMMENT = '4.1%';

  /**
   * height of back icon.
   */
  static readonly HEIGHT_BACK_ICON = '3.1%';

  /**
   * horizontal position of comment.
   */
  static readonly OFFSET_COMMENT_X = '-5%';

  /**
   * vertical position of comment.
   */
  static readonly OFFSET_COMMENT_Y = '10%';

  /**
   * vertical position of description.
   */
  static readonly OFFSET_DESCRIPTION_Y = '45%';

  /**
   * start position.
   */
  static readonly START_POSITION = '0%';

  /**
   * video play page.
   */
  static readonly PLAY_PAGE = 'pages/PageVideo';

  /**
   * home page.
   */
  static readonly HOME_PAGE = 'pages/SwiperIndex';

  /**
   * Rank item margin left sm.
   */
  static readonly RANK_ITEM_ML_SM: string = '2.2%';

  /**
   * Rank item margin left md.
   */
  static readonly RANK_ITEM_ML_MD: string = '1.2%';

  /**
   * Rank item margin left lg.
   */
  static readonly RANK_ITEM_ML_LG: string = '1.2%';

  /**
   * Rank title margin left.
   */
  static readonly RANK_TITLE_MARGIN_LEFT: string = '2.2%';

  /**
   * Search bar width md.
   */
  static readonly SEARCH_BAR_WIDTH_MD: string = '27.2%';

  /**
   *Search bar width lg.
   */
  static readonly SEARCH_BAR_WIDTH_LG: string = '18.1%';

  /**
   * Animation duration.
   */
  static readonly TAB_ANIMATION_DURATION: number = 300;

  /**
   * Water flow columns template normal.
   */
  static readonly WATER_FLOW_COLUMNS_TEMPLATE_NORMAL: string = '1fr';

  /**
   * Water flow columns template lg.
   */
  static readonly WATER_FLOW_COLUMNS_TEMPLATE_LG: string = '1fr 1fr';

  /**
   * Hot column item space sm.
   */
  static readonly HOT_COLUMN_IS_SM:string = '0vp';

  /**
   * Hot column item space md.
   */
  static readonly HOT_COLUMN_IS_MD:string = '49vp';

  /**
   * Hot column item space lg.
   */
  static readonly HOT_COLUMN_IS_LG:string = '81vp';

  /**
   * Swiper display count one.
   */
  static readonly SWIPER_DISPLAY_COUNT_ONE: number = 1;

  /**
   * Swiper display count two.
   */
  static readonly SWIPER_DISPLAY_COUNT_TWO: number = 2;

  /**
   * Swiper display count three.
   */
  static readonly SWIPER_DISPLAY_COUNT_THREE: number = 3;

  /**
   * Hot column max count.
   */
  static readonly HOT_COLUMN_MAX_COUNT: number = 5;

  /**
   * Hot item column space.
   */
  static readonly HOT_ITEM_COLUMN_SPACE: string = '4vp';

  /**
   * Top count.
   */
  static readonly TOP_COUNT: number = 3;

  /**
   * Search bar opacity.
   */
  static readonly SEARCH_BAR_OPACITY: number = 0.9;

  /**
   * Card item shadow radius.
   */
  static readonly CARD_ITEM_SHADOW_RADIUS: number = 10;

  /**
   * Icon more opacity.
   */
  static readonly ICON_MORE_OPACITY: number = 0.4;

  /**
   * Window padding sm.
   */
  static readonly WINDOW_PADDING_SM: string = '16vp';

  /**
   * Window padding md.
   */
  static readonly WINDOW_PADDING_MD: string = '23vp';

  /**
   * Window padding lg.
   */
  static readonly WINDOW_PADDING_LG: string = '32vp';

  /**
   * Linear gradient angel.
   */
  static readonly LINEAR_GRADIENT_ANGEL: number = 180;

  /**
   * Linear gradient from color.
   */
  static readonly LINEAR_GRADIENT_FROM_COLOR: string = '#FFFFFF';

  /**
   * Linear gradient to color.
   */
  static readonly LINEAR_GRADIENT_TO_COLOR: string = '#F1F3F5';

  /**
   * Linear gradient to area.
   */
  static readonly LINEAR_GRADIENT_TO_AREA: number = 0.02;

  /**
   * Follow item picture max height.
   */
  static readonly FOLLOW_ITEM_PICTURE_MAX_HEIGHT: string = '60%';

  /**
   * Follow title space.
   */
  static readonly FOLLOW_TITLE_SPACE: string = '24vp';

  /**
   * Linear gradient angle.
   */
  static readonly LINEAR_GRADIENT_ANGLE: number = 180;

  /**
   * Linear gradient from.
   */
  static readonly LINEAR_GRADIENT_FROM: number = 0.01;

  /**
   * Linear gradient to.
   */
  static readonly LINEAR_GRADIENT_TO: number = 0.92;

  /**
   * Subtitle opacity.
   */
  static readonly SUBTITLE_OPACITY: number = 0.6;

  /**
   * Swiper item space.
   */
  static readonly SWIPER_ITEM_SPACE: string = '20vp';

  /**
   * Title content space.
   */
  static readonly TITLE_CONTENT_SPACE: string = '4vp';

  /**
   * Window padding half sm.
   */
  static readonly WINDOW_PADDING_HALF_SM = '8vp';

  /**
   * Comment bar input width.
   */
  static readonly COMMENT_BAR_INPUT_WIDTH: string = '40%';

  /**
   * Comment bar input margin left.
   */
  static readonly COMMENT_BAR_INPUT_ML: string = '4.4%';

  /**
   * Text area max lines.
   */
  static readonly TEXT_AREA_MAX_LINES: number = 8;

  /**
   * Text area max length.
   */
  static readonly TEXT_AREA_MAX_LENGTH: number = 500;

  /**
   * Time position space.
   */
  static readonly TIME_POSITION_SPACE: string = '8vp';

  /**
   * Review count space.
   */
  static readonly REVIEW_COUNT_SPACE: string = '2vp';

  /**
   * Sub content max lines.
   */
  static readonly SUB_CONTENT_MAX_LINES: number = 2;

  /**
   * Max grid column.
   */
  static readonly MAX_GRID_COLUMN: number = 3;

  /**
   * Grid columns template.
   */
  static readonly GRID_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr';

  /**
   * Pinch gesture fingers.
   */
  static readonly PINCH_GESTURE_FINGERS: number = 2;

  /**
   * Suffix fp.
   */
  static readonly SUFFIX_FP: string = 'fp';

  /**
   * Suffix vp.
   */
  static readonly SUFFIX_VP: string = 'vp';

  /**
   * Max scale.
   */
  static readonly MAX_SCALE: number = 1.45;

  /**
   * Min scale.
   */
  static readonly MIN_SCALE: number = 0.75;

  /**
   * Content font size.
   */
  static readonly CONTENT_FONT_SIZE: number = 16;

  /**
   * Content font height.
   */
  static readonly CONTENT_FONT_HEIGHT: number = 25.6;

  /**
   * Picture margin top.
   */
  static readonly PICTURE_MARGIN_TOP: number = 8;


  /**
   * Grid horizontal gutter
   */
  public static readonly GRID_HORIZONTAL_GUTTER: string[] = ['24vp', '32vp'];

  /**
   * Grid vertical gutter
   */
  public static readonly GRID_VERTICAL_GUTTER: string[] = ['4vp', '16vp'];


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