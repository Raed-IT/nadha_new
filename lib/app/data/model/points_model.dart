class PointModel {
  int? id;
  double? credit;
  double? debit;
  int? orderId;
  String? productName;
  String? info;
  String? createdAt;

  PointModel(
      {this.id,
      this.credit,
      this.debit,
      this.orderId,
      this.productName,
      this.info,
      this.createdAt});

  PointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    credit = double.tryParse(json['credit'].toString());
    debit = double.tryParse(json['debit'].toString());
    orderId = json['order_id'];
    productName = json['product_name'];
    info = json['info'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['order_id'] = this.orderId;
    data['product_name'] = this.productName;
    data['info'] = this.info;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
