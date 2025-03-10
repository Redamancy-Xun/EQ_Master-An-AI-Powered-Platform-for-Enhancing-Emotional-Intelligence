
export class HomeConstants {
  /**
   * Grid row column list.
   */
  static readonly GRID_ROW_COLUMNS: number[] = [1, 2, 3, 4, 5];
  static readonly GRID_COL_COLUMNS: number[] = [0, 1, 2, 3, 4, 5];
  static readonly TAB_MESSAGE_INDEX = 0;
  /**
   * Index of CONTACTS tab.
   */
  static readonly TAB_CONTACTS_INDEX = 1;
  /**
   * Index of SOCIAL_CIRCLE tab.
   */
  static readonly TAB_SOCIAL_CIRCLE_INDEX = 2;
  /**
   * Index of ME tab.
   */
  static readonly TAB_ME_INDEX = 3;
  static readonly CONTACTS_DETAIL_AVATAR_Z_INDEX = 2;
  /**
   * Image message
   */
  static readonly USER_PHONE = '15988880000';
  static readonly LAST_POST = $r('app.string.news');
  static readonly IMAGES_SCOPE = 2;
  static readonly IMAGE_ASPECT_RATIO = 1;
  /**
   * Contacts list detail
   */
  static readonly CONTACTS_NAME = $r('app.string.Contacts');
  static readonly CONTACTS_LIST = [$r('app.string.group'), $r('app.string.card')];
  static readonly CONTACTS_DEFAULT_SELECTED_INDEX = 0;
  static readonly CONTACTS_DEFAULT_SELECTED_NAME = $r('app.string.Alan');
  /**
   * Conversation detail
   */
  static readonly CONVERSATION_LIST_APPLET = [$r('app.string.milk'), $r('app.string.Speed'), $r('app.string.happy')];
  static readonly CONVERSATION_LIST_DOCUMENT = [$r('app.string.plan'), $r('app.string.jack'), $r('app.string.ok')];
  static readonly IS_APPLET_CONVERSATION = true;
  static readonly IS_DOCUMENT_CONVERSATION = true;
  static readonly IS_RECEIVED = true;
  static readonly CONVERSATION_DEFAULT_SIZE = 3;
  static readonly CONVERSATION_TITLE = $r('app.string.Message');
  /**
   * Conversation top search
   */
  static readonly SEARCH_TEXT_FLEX_BASIS = 150;
  static readonly SEARCH_TEXT_INPUT = $r('app.string.search');
  static readonly ENABLE_KEY_BOARD_ON_FOCUS = false;
  static readonly FLEX_BASIS_AUTO = 'auto';
  /**
   * Conversation detail
   */
  static readonly CONVERSATION_DETAIL_BOTTOM_TEXT_RADIUS = 20;
  static readonly CONVERSATION_DETAIL_TOP_TITLE = '芬芬';
  static readonly CONVERSATION_DETAIL_MAX_LINE = 1;
  static readonly CONVERSATION_DETAIL_FILL_OPACITY = 1;
  static readonly CONVERSATION_DETAIL_STROKE_WIDTH = 1;
  static readonly PATH_BORDER_RADIUS = 8;
  /**
   * Applet detail
   */
  static readonly APPLET_TITLE = '奶茶';
  static readonly APPLET_DESCRIBE = '应用';
  /**
   * Document detail
   */
  static readonly DOCUMENT_SIZE = '24KB';
  static readonly DOCUMENT_INTRODUCE = $r('app.string.document');
  static readonly DOCUMENT_DIVIDER_WIDTH = 1;
  /**
   * Default avatar
   */
  static readonly DEFAULT_AVATAR = $r('app.media.EQ_Master_start_icon')
  /**
   * Navigation navBarWidth percent
   */
  static readonly NAVIGATION_NAV_BAR_WIDTH_MD = '50%'
  static readonly NAVIGATION_NAV_BAR_WIDTH_LG = '44.5%'
}