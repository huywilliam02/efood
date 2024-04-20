import 'package:citgroupvn_efood_table/app/modules/home/home.dart';

class TabOrderDetailsWidget extends StatelessWidget {
  const TabOrderDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0.0, -100.0, 0.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: Get.isDarkMode
                      ? null
                      : [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: const Offset(0, 4))
                        ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${'note'.tr}: ", style: robotoBold),
                          const Expanded(
                              child: Text(
                            'Here is your not will be appear from customer Here is your not will be appear from customer',
                            maxLines: 5,
                            overflow: TextOverflow.clip,
                          )),
                        ],
                      ),
                    ),
                    const CustomDivider(),
                    SizedBox(height: Dimensions.paddingSizeDefault),
                  ],
                ),
              ),
              ClipPath(
                clipper: MultipleRoundedCurveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
