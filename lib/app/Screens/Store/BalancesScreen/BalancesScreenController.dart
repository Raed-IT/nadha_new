import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/TransformModel.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class BalancesScreenController extends GetxController
    with PaginationMixin<TransformModel> {
  @override
  void onInit() {
    super.onInit();
    paginationUrl = ApiRoute.transforms;
    getPaginationData(isRefresh: true);
  }

  @override
  List<TransformModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<TransformModel> transforms = [];
    for (var transform in json["data"]['transforms']) {
      transforms.add(TransformModel.fromJson(transform));
    }
    return transforms;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
