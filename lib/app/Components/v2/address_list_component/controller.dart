  import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:get/get.dart';

class AddressListController extends GetxController
{
  RxList<AddressModel> addresses=RxList(Get.find<MainController>().user.value?.addresses??[]);



}
