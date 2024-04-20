import 'package:efood_kitchen/data/model/response/language_model.dart';
import 'package:efood_kitchen/util/images.dart';

class AppConstants {
  static const String appName = 'Kitchen App';
  static const double appVersion = 1.5;

  // demo
  static const String baseUrl = 'https://quanlynhahang.citgroup.vn/';
  static const String configUri = '/api/v1/config';
  static const String loginUri = '/api/v1/auth/kitchen/login';
  static const String profileUri = '/api/v1/kitchen/profile';
  static const String orderList = '/api/v1/kitchen/order/list';
  static const String orderDetails = '/api/v1/kitchen/order/details';
  static const String orderStatusUpdate = '/api/v1/kitchen/order/status';
  static const String searchOrder = '/api/v1/kitchen/order/search?search=';
  static const String filterOrder =
      '/api/v1/kitchen/order/filter?order_status=';
  static const String fcmTokenUri = '/api/v1/kitchen/update-fcm-token';

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String topic = 'kitchen';
  static const String branchId = 'branch_id';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.unitedKingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: Images.bd,
        languageName: 'Bengali',
        countryCode: 'BD',
        languageCode: 'bn'),
    LanguageModel(
        imageUrl: Images.india,
        languageName: 'Hindi',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(
        imageUrl: Images.spain,
        languageName: 'Spanish',
        countryCode: 'ES',
        languageCode: 'es'),
  ];
}
