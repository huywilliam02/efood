import 'package:citgroupvn_efood_table/app/modules/home/home.dart';

class MySliverHeader extends SliverPersistentHeaderDelegate {
  MySliverHeader({
    required this.minExtent,
    required this.maxExtent,
    required this.widget,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;
  final Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}