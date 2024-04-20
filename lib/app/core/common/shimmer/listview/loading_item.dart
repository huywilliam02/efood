import 'package:citgroupvn_efood_table/app/core/common/shimmer/rounded_rectangle_shimmer.dart';
import 'package:flutter/material.dart';


class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return RounedRectangleShimmer(
      width: double.infinity,
      height: 60,
    );
  }
}
