import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  RxList<bool> selectedButton = RxList([true, false]);
  RxInt selectedIndex = RxInt(1);

  // user
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController bioTextController = TextEditingController();
  CityModel? city;

  @override
  void onReady() {
    super.onReady();
    UserModel user = Get.find<MainController>().user.value!;
    nameTextController.text = "${user.name}";
    emailTextController.text = "${user.email}";
    phoneTextController.text = user.phone ?? '';
    city = user.city!;
    bioTextController.text = user.bio ?? '';
  }

  void onSelectedButton(int index) {
    selectedIndex.value = index;
    selectedButton.value = [false, false];
    selectedButton[index] = true;
  }
}
