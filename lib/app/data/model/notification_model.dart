class NotificationModel {
  String? title;
  String? url;
  String? msg;
  bool? isUrl;

  NotificationModel({this.title, this.url, this.msg, this.isUrl});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    isUrl = json['is_url'];
    msg = json['msg'];
  }
}
