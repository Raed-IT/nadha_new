import 'package:logger/logger.dart';

class SettingModel {
  String? phone;
  String? email;
  String? about;
  bool? isClosed;

  SettingModel(this.phone, this.email, this.about, this.isClosed);

  SettingModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    about = json['about'];
    isClosed = json['is_close'] as bool;
  }
}
