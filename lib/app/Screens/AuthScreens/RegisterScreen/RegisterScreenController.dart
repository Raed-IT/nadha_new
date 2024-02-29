import 'package:delevary/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  RxBool keyboardVisible = RxBool(false);
  Future<void> register() async {
    if (formKey.currentState!.validate()) {}
  }
  Future<void> loginWithGoogle() async {
    AuthService authService = AuthService();
    authService.signin(onCompleted: (data) {
      Get.snackbar("تم ", data?.email ?? '');
    });
  }

}