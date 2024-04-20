import 'package:efood_kitchen/view/screens/auth/login_screen.dart';
import 'package:efood_kitchen/view/screens/home/home_screen.dart';
import 'package:efood_kitchen/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getLoginRoute() => login;
  static getHomeRoute(String name) => '$home?name=$name';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: login, page: () => const LoginScreen()),

  ];
}