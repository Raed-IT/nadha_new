class OptionModel {
  double? minBill;
  double? fare;
  bool? isOpen;
  String? msgClose;
  String? phone;

  OptionModel({this.minBill, this.fare, this.isOpen, this.msgClose});

  OptionModel.fromJson(Map<String, dynamic> json) {
    minBill = double.tryParse(json['min_bill'].toString());
    fare = double.tryParse(json['fare'].toString());
    isOpen = json['is_open'];
    phone = json['phone'];
    msgClose = json['msg_close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_bill'] = this.minBill;
    data['fare'] = this.fare;
    data['is_open'] = this.isOpen;
    data['msg_close'] = this.msgClose;
    return data;
  }
}
