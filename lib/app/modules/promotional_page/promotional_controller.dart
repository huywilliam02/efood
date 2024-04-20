import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/controller/splash_controller.dart';
import 'package:citgroupvn_efood_table/data/model/response/config_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PromotionalController extends BaseController implements GetxService {
  bool _isFixTable = false;

  bool get isFixTable => _isFixTable;

  void changeFixTable(bool value) {
    _isFixTable = value;
    update();
  }

  List<String> _videoIds = [];

  List<String> get videoIds => _videoIds;

  void getVideoUrls() {
    _videoIds = [];
    List<BranchPromotion> list = getPromotion('video');
    for (var branchPromotion in list) {
      if (branchPromotion.promotionName != null) {
        _videoIds.add(
          '${YoutubePlayer.convertUrlToId(branchPromotion.promotionName!)}',
        );
      }
    }
  }

  List<BranchPromotion> getPromotion(String type, {bool all = false}) {
    List<BranchPromotion> branchPromotionList = [];
    try {
      branchPromotionList = Get.find<SplashController>()
              .configModel
              ?.promotionCampaign
              ?.firstWhere(
                (campaign) =>
                    campaign.id == Get.find<SplashController>().getBranchId(),
              )
              .branchPromotion
              ?.toList() ??
          [];
    } catch (e) {
      branchPromotionList = [];
    }

    if (!all) {
      branchPromotionList
          .removeWhere((element) => element.promotionType != type);
    }

    return branchPromotionList;
  }
}
