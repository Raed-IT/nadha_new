import 'package:delevary/app/Components/AppBarComponent.dart';
import 'package:delevary/app/Components/SafeAreaComponent.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/LoadingComponents/HorizontalListLoading.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            AppBarComponent(),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  100.verticalSpace,
                  Container(
                    height: 10000,
                    color: Colors.redAccent,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
