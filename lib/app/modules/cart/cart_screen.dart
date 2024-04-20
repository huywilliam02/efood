import 'cart.dart';

class CartView extends BaseView<CartController> {
  final bool isOrderDetails;
  const CartView({Key? key, this.isOrderDetails = false}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(onBackPressed: null, showCart: false),
      body: CartDetails(showButton: !isOrderDetails),
    );
  }
}