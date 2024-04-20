import 'package:citgroupvn_efood_table/app/routes/app_routes.dart';
import 'package:citgroupvn_efood_table/app/modules/promotional_page/promotional.dart';
import 'package:citgroupvn_efood_table/app/modules/promotional_page/promotional_page.dart';

class SettingWidget extends StatefulWidget {
  final bool formSplash;
  const SettingWidget({Key? key, required this.formSplash}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  List<String> _errorText = [];

  @override
  void initState() {
    final splashController = Get.find<SplashController>();

    if (splashController.getBranchId() < 1) {
      splashController.updateBranchId(null, isUpdate: false);
    } else {
      splashController.updateBranchId(splashController.getBranchId(),
          isUpdate: false);
    }
    TableModel? table = splashController.getTable(splashController.getTableId(),
        branchId: splashController.getBranchId());

    if (table == null || splashController.getTableId() < 1) {
      splashController.updateFixTable(false, false);
      splashController.updateTableId(null, isUpdate: false);
    } else {
      splashController.updateTableId(splashController.getTableId(),
          isUpdate: false);
      splashController.updateFixTable(true, false);
    }
    splashController.updateFixTable(splashController.getIsFixTable(), false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<SplashController>(builder: (splashController) {
        bool isAvailable = false;
        // splashController.configModel?.branch?.map((Branch value) {
        //   if(value.id == splashController.selectedBranchId){
        //     isAvailable = true;
        //   }
        // });

        if (splashController.configModel != null &&
            splashController.configModel!.branch != null) {
          for (int i = 0;
              i < splashController.configModel!.branch!.length;
              i++) {
            if (splashController.configModel!.branch![i].id ==
                splashController.selectedBranchId) {
              isAvailable = true;
            }
          }
        }

        if (!isAvailable) {
          splashController.setBranch(-1, isUpdate: false);
          splashController.updateBranchId(null, isUpdate: false);
        }

        return Container(
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeExtraLarge,
              horizontal: Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'table_setup'.tr,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeExtraLarge),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.4))
                    // boxShadow: [BoxShadow(color: Theme.of(context).cardColor, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 5))],
                    ),
                child: DropdownButton<int>(
                  menuMaxHeight: Get.height * 0.5,
                  hint: Text(
                    'select_your_branch'.tr,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                  value: splashController.selectedBranchId,
                  items:
                      splashController.configModel?.branch?.map((Branch value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Text(
                        value.name ?? 'no branch',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _errorText = [];
                    splashController.updateBranchId(value!);
                    splashController.updateTableId(null);
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                'set_fix_table_number'.tr,
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault),
              ),
              SizedBox(height: Dimensions.paddingSizeDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                      title: Text('yes'.tr, style: robotoRegular),
                      value: true,
                      groupValue: splashController.isFixTable,
                      onChanged: (bool? value) {
                        if (splashController.selectedBranchId != null) {
                          splashController.updateFixTable(true, true);
                        } else {
                          splashController.updateFixTable(true, true);
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) {
                            _errorText = [];
                            _errorText.add('please_select_your_branch'.tr);
                            splashController.updateFixTable(false, true);
                          });
                        }
                        splashController.updateTableId(null);
                      },
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
                      title: Text('no'.tr, style: robotoRegular),
                      value: splashController.isFixTable,
                      groupValue: false,
                      onChanged: (bool? value) =>
                          splashController.updateFixTable(false, true),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeDefault),
              if (splashController.isFixTable &&
                  splashController.selectedBranchId != null)
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4))
                      // boxShadow: [BoxShadow(color: Theme.of(context).cardColor, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 5))],
                      ),
                  child: DropdownButton<int>(
                    menuMaxHeight: Get.height * 0.5,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    hint: Text(
                      'set_your_table_number'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                    value: splashController.selectedTableId,
                    items: splashController.configModel?.branch
                        ?.firstWhere((branch) =>
                            branch.id == splashController.selectedBranchId)
                        .table
                        ?.map((value) {
                      return DropdownMenuItem<int>(
                        value: value.id,
                        child: Text(
                          '${value.id == -1 ? 'no_table_available'.tr : value.number}',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      splashController.updateTableId(value == -1 ? null : value,
                          isUpdate: true);
                    },
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
              if (_errorText.isNotEmpty)
                Text(_errorText.first,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).colorScheme.error,
                    )),
              SizedBox(height: Dimensions.paddingSizeDefault),
              CustomButton(
                height: 40,
                width: 285,
                buttonText: 'save'.tr,
                onPressed: () {
                  if (splashController.selectedTableId == null &&
                      splashController.isFixTable) {
                    _errorText = [];
                    _errorText.add('set_your_table_number'.tr);
                    splashController.update();
                  } else if (splashController.selectedBranchId == null) {
                    _errorText = [];
                    _errorText.add('please_select_your_branch'.tr);
                    splashController.update();
                  } else {
                    if (splashController.isFixTable) {
                      splashController.setFixTable(true);
                      splashController
                          .setTableId(splashController.selectedTableId!);
                    } else {
                      splashController.setFixTable(false);
                      splashController.setTableId(-1);
                    }
                    splashController
                        .setBranch(splashController.selectedBranchId!);
                    if (widget.formSplash) {
                      if (ResponsiveHelper.isTab(context) &&
                          (Get.find<PromotionalController>()
                              .getPromotion('', all: true)
                              .isNotEmpty)) {
                        Get.offAll(() => const PromotionalPageScreen());
                      } else {
                        Get.offAllNamed(Routes.home);
                      }
                    } else {
                      Get.find<ProductController>().getProductList(true, true);
                      Get.find<PromotionalController>().update();
                      Get.back();
                    }
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
