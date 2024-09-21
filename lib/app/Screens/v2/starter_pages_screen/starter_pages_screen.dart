import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/starter_pages_screen/starter_pages_screen_controller.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:logger/logger.dart';

class StarterPageScreen extends GetView<StarterPageScreenController> {
  const StarterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _introKey = GlobalKey<IntroductionScreenState>();
    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        showSkipButton: true,
        pages: [
          PageViewModel(
            title: "توصيل سريع",
            body: "توصيل سريع الى كل الأماكن في معرة مصرين ",
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              bodyFlex: 1,
              titleTextStyle:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              bodyTextStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
            ),
            image: Image.asset(
              "assets/images/v2/devilry.png",
              height: 207.h,
            ),
          ),
          PageViewModel(
            title: "كل ماتحتاج",
            body:
                "يمكنك شراء كل ماتحتاج من خلال تطبيقنا مثل البقالة والطعام والقرطاسية وغيرها ",
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              bodyFlex: 1,
              titleTextStyle:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              bodyTextStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
            ),
            image: Image.asset(
              "assets/images/v2/phone.png",
              height: 207.h,
            ),
          ),
          PageViewModel(
            title: "عروض لا تنتهي",
            body:
                "عروض دائمة لمستخدمينا بالاضافة لحصولك على نقاط في كل مرة تشتري من خلال تطبيقنا ",
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              bodyFlex: 1,
              titleTextStyle:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              bodyTextStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
            ),
            image: Image.asset(
              "assets/images/v2/sale.png",
              height: 207.h,
            ),
          ),
        ],
        allowImplicitScrolling: true,
        showNextButton: true,
        next: MaterialButton(
          height: 35.h,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            _introKey.currentState?.next();
          },
          child: Text(
            "التالي",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        ),
        done: MaterialButton(
          height: 35.h,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            Logger().w("sdsdsds");
            await LocaleStorageService.setIsReadStarterPages();
               Get.offAllNamed(AppRoutes.mainAuthScreen);

          },
          child: Text(
            "تم ",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        ),
        skip: MaterialButton(
          onPressed: () async {
            _introKey.currentState?.skipToEnd();
          },
          child: Text("تجاهل"),
        ),
        onDone: () async {},
      ),
    );
  }
}
