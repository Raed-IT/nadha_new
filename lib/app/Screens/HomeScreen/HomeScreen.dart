import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home Screen ",
              style: TextStyle(color: Colors.red),
            ),
            FilledButton(onPressed: () =>LocaleStorageService.logOut(), child: Text("تسجيل الخروج"))
          ],
        ),
      ),
    );
  }
}
