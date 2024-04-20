class Routes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String maintabview = '/main-tabview';
  static const String orderList = '/order-list';
  static const String settings = '/settings';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getHomeRoute(String name) => '$home?name=$name';
  static const ORDER_RM = '/order-rm';
  static const ORDER_DETAIL = '/order-detail';
  static const ORDER_DETAIL_RM = '/order-detail-rm';
  static const ORDER_DETAIL_UPDATE_RM = '/order-detail-update-rm';
  static const LOGIN = '/login';
}
