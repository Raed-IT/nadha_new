import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/model/points_model.dart';
import 'package:nadha/app/data/model/user_model.dart';

class BalanceScreenController extends GetxController
    with PaginationMixin<PointModel> {
  RxString totalBalance = RxString("0");
  RxString totalPoint = RxString("0");
  RxInt setectedItem = RxInt(0);

  @override
  void onInit() {
    url = ApiRouts.points;
    setectedItem.listen((p0) {
      if (p0 == 1) {
        url = ApiRouts.points;
      } else {
        url = ApiRouts.balances;
      }
      getPaginationData(isRefresh: true);
    });
    getData();
    super.onInit();
  }

  void getData() async {
    EasyLoading.show();
    await getPaginationData(isRefresh: true);
    EasyLoading.dismiss();
  }

  @override
  List<PointModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    EasyLoading.dismiss();
    List<PointModel> points = [];
    totalBalance.value = json['data']["total_balance"].toString();
    totalPoint.value = json['data']["total_point"].toString();
    if (json['data'].containsKey("points")) {
      for (var point in json['data']['points']) {
        points.add(PointModel.fromJson(point));
      }
    } else {
      for (var point in json['data']['balances']) {
        points.add(PointModel.fromJson(point));
      }
    }
    return points;
  }
}
