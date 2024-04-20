import 'package:citgroupvn_efood_table/app/resources/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CommonCreateEditItem extends StatelessWidget {
  final String title;
  final String obligatory;
  final Widget widget;

  const CommonCreateEditItem({
    super.key,
    required this.title,
    required this.widget,
    this.obligatory = "",
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              Text(title, style: AppTextStyle.textTitleForm),
              const SizedBox(width: 5),
              Text(obligatory, style: AppTextStyle.textTitleFormobligatory),
            ],
          ),
          const SizedBox(height: 10),
          widget
        ],
      ),
    );
  }
}
