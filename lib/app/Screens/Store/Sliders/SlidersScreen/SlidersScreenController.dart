import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class SlidersStoreScreenController extends GetxController
    with PaginationMixin<SliderModel>, ApiHelperMixin {
  @override
  void onInit() {
    super.onInit();
    paginationUrl = ApiRoute.sliders;
    paginationParameter = {
      "store_id": Get.find<MainController>().user.value?.store?.id
    };

    getDataFromApi();
  }

  Future<bool> triggerStatus(SliderModel slid) async {
    bool status = false;
    await postData(
        url: "${ApiRoute.sliders}/${slid.id}",
        data: {},
        onSuccess: (data, t) {
          if (data.data['status'] == "SUCCESS") {
            status = true;
          }
        },
        onError: (e, t) {});
    return status;
  }

  deleteSlider(SliderModel slid, BuildContext context) async {
    Get.back();
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.sliders}/${slid.id}",
        data: {"_method": "DELETE"},
        onSuccess: (res, t) {
          ToastService.showSuccessToast(
              context: context, title: "تم حذف الإعلان");
          paginationData.remove(slid);
        },
        onError: (ex, t) {});
    OverlayLoaderService.hide();
  }

  Future getDataFromApi() async {
    await getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  List<SliderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<SliderModel> sliders = [];
    for (var slid in json['data']["sliders"]) {
      sliders.add(SliderModel.fromJson(slid));
    }
    return sliders;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
