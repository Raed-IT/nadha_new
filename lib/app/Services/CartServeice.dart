// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:helper_plugin/helper.dart';
// import 'package:logger/logger.dart';
// import 'package:nadha/app/data/api_routs.dart';
// import 'package:nadha/app/data/inital/main_controller.dart';
// import 'package:nadha/app/data/model/cart_item_model.dart';
// import 'package:dio/dio.dart' as dio;
//
// class CartService with ApiHelperMixin {
//   Future<void> addProductToCart({required CartItemModel cartItem}) async {
//     String kye;
//     String val;
//     if (cartItem.quantity != null && cartItem.quantity!.value > 0) {
//       kye = "quantity";
//       val = cartItem.quantity!.value.toString();
//     } else {
//       kye = "price";
//       val = cartItem.price.toString();
//     }
//     dio.FormData data =
//         dio.FormData.fromMap({"product_id": cartItem.product!.id, kye: val});
//     await postDataDio(url: ApiRouts.cart, data: data);
//   }
//
//   @override
//   void getDataFromPostDioUsing(json) {
//     Get.find<MainController>()
//         .cartItems
//         .add(CartItemModel.fromJson(json['data']['cart']));
//     Fluttertoast.showToast(msg: "تمت الإضافة الى السلة");
//   }
//
//   Future<bool> deleteCartItem({required CartItemModel cartItem}) async {
//     return await deleteGetConnect(url: ApiRouts.cart, id: cartItem.id!);
//   }
//
//   @override
//   void onDeleteSuccess() {
//     Fluttertoast.showToast(msg: "تم حذف العنصر ");
//   }
// }
