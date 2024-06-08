import 'package:delevary/app/Data/Models/NotificationModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class NotificationScreenController extends GetxController
    with PaginationMixin<NotificationModel>, ApiHelperMixin {
  Future<void> getFreshData() async {
    await getPaginationData(isRefresh: true);
  }

  loadMore() {
    getPaginationData(isRefresh: false);
  }

  deleteNotifications(BuildContext context) async {
    OverlayLoaderService.show(context);
    await postData(
        url: ApiRoute.notifications,
        data: {"_method": "DELETE"},
        onSuccess: (res, t) {
          paginationData.clear();
        },
        onError: (res, t) {});
    Loader.hide();
  }

  @override
  void onInit() {
    paginationUrl = ApiRoute.notifications;
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  @override
  List<NotificationModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<NotificationModel> notifications = [];
    for (var notification in json['data']['notifications']) {
      notifications.add(NotificationModel.fromJson(notification));
    }
    return notifications;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']['next_page_url'];
  }
}
