import 'package:get/get.dart';

class NotificationModel {
  String? id;

  String? title;
  String? body;
  RxBool? isRead;

  NotificationModel(this.id, this.title, this.body);

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isRead = RxBool(json['is_read'] as bool);
  }
}
