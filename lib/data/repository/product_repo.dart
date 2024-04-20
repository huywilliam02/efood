import 'package:citgroupvn_efood_table/data/api/api_client.dart';
import 'package:citgroupvn_efood_table/app/core/constants/app_constants.dart';
import 'package:get/get.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getProductList(int offset, String? productType,
      String? searchPattern, String? categoryId) async {
    String params = '?limit=13&offset=$offset';

    if (productType != null) {
      params = '$params&product_type=$productType';
    }
    if (searchPattern != null) {
      params = '$params&name=$searchPattern';
    }
    if (categoryId != null) {
      params = '$params&category_ids=$categoryId';
    }
    return await apiClient.getData('${AppConstants.productUri}$params');
  }

  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.categoryUri);
  }

  Future<Response> getCategoryProductList(String categoryID) async {
    return await apiClient
        .getData('${AppConstants.categoryProductUri}/$categoryID');
  }
}
