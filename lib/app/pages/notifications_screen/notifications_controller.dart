import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';

import '../../data/model/notification_model.dart';

class NotificationsScreenController extends GetxController
    with PaginationMixin<NotificationModel> {
  @override
  void onInit() {
    url = ApiRouts.notifications;
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1),
        () => Get.find<MainController>().notificationsCount.value = 0);
    super.onReady();
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
}
