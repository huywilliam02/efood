import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/emergency_contact_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_app_bar.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_delegate.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_search_field.dart';
import 'package:citgroupvn_eshop_seller/view/screens/delivery/emergency_contact/widget/add_emergency_contact.dart';
import 'package:citgroupvn_eshop_seller/view/screens/delivery/emergency_contact/widget/emergency_contact_list.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    Provider.of<EmergencyContactProvider>(context, listen: false)
        .getEmergencyContactListList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('emergency_contact', context),
        isBackButtonExist: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                delegate: SliverDelegate(
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault),
                      child: CustomSearchField(
                        controller: searchController,
                        hint: getTranslated('search', context),
                        prefix: Images.iconsSearch,
                        iconPressed: () => () {},
                        onSubmit: (text) => () {},
                        onChanged: (value) {},
                        isFilter: false,
                      ),
                    ))),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  EmergencyContactListView(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(
          Icons.add_circle,
          size: Dimensions.iconSizeExtraLarge,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return const AddEmergencyContact();
              });
        },
      ),
    );
  }
}
