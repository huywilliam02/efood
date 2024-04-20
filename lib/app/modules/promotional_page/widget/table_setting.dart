import 'package:citgroupvn_efood_table/app/modules/promotional_page/promotional.dart';
class TableSetting extends StatelessWidget {
  const TableSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius:
            BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'set_fix_table_number'.tr,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
          SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),

          GetBuilder<SplashController>(builder: (splashController) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    title: Text('yes'.tr),
                    value: true,
                    groupValue: true,
                    onChanged: (Object? value) {},
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    title: Text('no'.tr),
                    value: '',
                    groupValue: false,
                    onChanged: (Object? value) {},
                  ),
                ),
              ],
            );
          }),

          SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),

          SizedBox(
            width: 200,
            child: CustomButton(
              buttonText: 'save'.tr,
              onPressed: () {},
            ),
          ),

          // ListView.builder(
          //   itemCount: 2,
          //   itemBuilder: (context, index) => RadioListTile(
          //     activeColor: Theme.of(context).primaryColor,
          //     contentPadding: EdgeInsets.zero,
          //     dense: true,
          //     visualDensity: const VisualDensity(
          //       horizontal: VisualDensity.minimumDensity,
          //       vertical: VisualDensity.minimumDensity,
          //     ),
          //
          //     title: Text(''),
          //     value: index, groupValue: false,
          //     onChanged: (Object? value) {
          //
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
