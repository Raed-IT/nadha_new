import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:get/get.dart';

class SearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchScreenController());

  }

}