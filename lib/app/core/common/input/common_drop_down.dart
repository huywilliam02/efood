import 'package:citgroupvn_efood_table/app/core/common/input/common_create_edit_item.dart';
import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  final String title;
  final List<String> listValues;
  final String selectedValue;
  final void Function(String?)? onSelected;
  final Map<String, String> dropdownLabels;

  const CommonDropdown({
    super.key,
    required this.title,
    required this.listValues,
    required this.selectedValue,
    required this.onSelected,
    required this.dropdownLabels,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCreateEditItem(
      title: title,
      widget: Container(
        height: 65,
        width: double.infinity, // Adjust the width as needed
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: PopupMenuButton<String>(
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            return listValues.map((String value) {
              return PopupMenuItem<String>(
                value: value,
                child: SizedBox(
                  // height: 60, // Match the height of CommonCreateEditItem
                  child: Center(
                    child: Text(
                      dropdownLabels[value] ?? value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            }).toList();
          },
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black), // Add border color if needed
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    dropdownLabels[selectedValue] ?? selectedValue,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// _buildDropdownItem(
//   title: "Hoạt động",
//   listValues: controller.listIsLockedDropdown,
//   selectedValue: controller.dropdownIsLockedValue.value,
//   onSelected: (String? value) {
//     controller.dropdownIsLockedValue.value = value!;
//   },
// ),
// _buildDropdownItem(
//   title: "Chọn quyền",
//   listValues: controller.listRoleDropdown,
//   selectedValue: controller.dropdownRoleValue.value,
//   onSelected: (String? value) {
//     controller.dropdownRoleValue.value = value!;
//   },
// ),
// Widget _buildDropdownItem({
//   required String title,
//   required List<String> listValues,
//   required String selectedValue,
//   void Function(String?)? onSelected,
// }) {
//   return CommonCreateEditItem(
//     title: title,
//     widget: Container(
//       height: 60,
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: DropdownButtonHideUnderline(
//         child: DropdownMenu<String>(
//           initialSelection: selectedValue,
//           onSelected: onSelected,
//           dropdownMenuEntries:
//           listValues.map<DropdownMenuEntry<String>>((String value) {
//             return DropdownMenuEntry<String>(
//               value: value,
//               label: controller.roleLabels[value] ?? value,
//               style: MenuItemButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 minimumSize: const Size(285, 50),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ),
//   );
// }
