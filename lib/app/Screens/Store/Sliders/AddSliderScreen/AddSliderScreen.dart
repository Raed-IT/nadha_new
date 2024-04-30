import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/ImagePickerComponent.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Screens/Store/Sliders/AddSliderScreen/AddSliderScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Components/AppBarComponents/AppBarComponent.dart';

class AddSliderScreen extends GetView<AddSliderScreenController> {
  const AddSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ).animate().blur(
                    delay: const Duration(milliseconds: 500),
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 2),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    title: "إضافة إعلان",
                    openDrawer: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child:Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: BlurryContainer(
                          blur: 7,
                          child: ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              20.verticalSpace,
                              ImagePickerComponent(
                                onPicked: (files) {
                                  if (files.isNotEmpty) {
                                    controller.image = files.first;
                                  } else {
                                    controller.image = null;
                                  }
                                },
                                image: "",
                                title: Text(
                                  'صورة الإعلان',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ),
                              20.verticalSpace,
                              TextFieldComponent(
                                  validator: (url) {
                                    if (url!.isEmpty) {
                                      return "الرجاء كتابة رابط";
                                    } else if (!url.isURL) {
                                      return "الرجاء ادخال رابط صحيح";
                                    }
                                    return null;
                                  },
                                  controller: controller.urlController,
                                  hint: "رابط الإعلان"),
                              20.verticalSpace,
                              SizedBox(
                                height: 50.h,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.sp)),
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () => controller.addSlider(context),
                                  child: Text(
                                    "إضافة الإعلان",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
