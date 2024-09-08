import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/model/product_model.dart';

class ProductDetailsController extends GetxController {
  ProductModel product = Get.arguments['product'];
  bool isFromStore = Get.arguments["isFromStore"] ?? false;
  bool isOffer = Get.arguments["isOffer"] ?? false;

}
