// File: get_all_data_users_request.dart
import 'package:citgroupvn_efood_table/data/api_request_representable.dart';
import 'package:citgroupvn_efood_table/data/enums/http_method.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/providers/api_provider.dart';

class GetAllDataUsersRequest implements APIRequestRepresentable {
  final int indexPage;
  String? token;
  GetAllDataUsersRequest(this.indexPage);

  @override
  String get url =>
      'https://dev-quanlynhahang.citgroup.vn/api/v1/table/order/details?order_id=100001&branch_table_token=HxYAgMXOCfJGGI0cEYRJkFCjplY7UIWlyrrtdVgQW46RkNTmzW';
  @override
  String get endpoint => 'users'; // You can define an endpoint if needed

  @override
  String get path => '/api/users'; // You can define the path if needed

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, String>? get query => null;

  @override
  get body => null;

  @override
  Future<OderListDetails> request() async {
    try {
      final response = await APIProvider.instance.request(this);
      return _returnResponse(response);
    } catch (e) {
      // Propagate the exception
      throw e;
    }
  }

  Future<OderListDetails> _returnResponse(dynamic response) async {
    try {
      // Check if the response is a Map
      if (response is Map<String, dynamic>) {
        // Check if 'order' property is present
        if (response.containsKey('order')) {
          // Extract the 'order' property
          final dynamic orderData = response['order'];
          // Check if 'details' property is present
          if (response.containsKey('details')) {
            // Extract the 'details' property
            final List<dynamic> detailsData = response['details'];
            // Parse 'details' into a list of Detail objects
            List<Detail> details =
                detailsData.map((json) => Detail.fromJson(json)).toList();
            // Parse 'order' into an Order object
            Order order = Order.fromJson(orderData as Map<String, dynamic>);
            // Return an instance of OderListDetails with the parsed order and details
            return OderListDetails(order: order, details: details);
          } else {
            // Handle situations where 'details' is not present
            throw Exception('Failed to load user data. Details not present.');
          }
        } else {
          // Handle situations where 'order' is not present
          throw Exception('Failed to load user data. Order not present.');
        }
      } else {
        // Handle situations where response is not a Map
        throw Exception(
            'Failed to load user data. Unexpected response format.');
      }
    } catch (e) {
      // Handle other exceptions or errors
      throw Exception('Failed to load user data. Exception occurred. $e');
    }
  }
}
