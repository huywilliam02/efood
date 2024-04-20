import 'package:citgroupvn_efood_table/app/util/images.dart';
import 'package:citgroupvn_efood_table/data/model/response/language_model.dart';

class AppConstants {
  static const String appName = 'CIT eFood Table';
  static const String appVersion = '1.5';

  // demo
  static const String baseUrl = 'https://res-admin.citgroup.vn';
  static const String configUri = '/api/v1/config/table';
  static const String categoryUri = '/api/v1/categories';
  static const String productUri = '/api/v1/products/latest';
  static const String categoryProductUri = '/api/v1/categories/products';

  static const String placeOrderUri = '/api/v1/table/order/place';
  static const String updatePlaceOrderUri = '/api/v1/table/order/update';

  static const String orderDetailsUri = '/api/v1/table/order/details?';
  static const String orderListUri =
      '/api/v1/table/order/list?branch_table_token=';

  static const String checkInfo = '/api/v1/check-info-by-branch?code=';

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
  static const String topic = 'notify';
  static const String tableNumber = 'table_number';
  static const String branch = 'branch';
  static const String orderInfo = 'order_info';
  static const String isFixTable = 'is_fix_table';
  static const String checkInfoCompany = 'check_Info';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.vietnam,
        languageName: 'Tiếng Việt',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.unitedKingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
