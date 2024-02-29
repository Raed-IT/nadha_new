import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthController.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainAuthScreen extends GetView<MainAuthScreenController> {
  const MainAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                filterQuality: FilterQuality.high,
                image: AssetImage('assets/images/bg.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ).animate().blur(
                begin: const Offset(20, 20),
                duration: const Duration(seconds: 2),
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              50.verticalSpace,
              Expanded(
                child: Image.asset("assets/images/logo.png").animate().scale(
                      duration: const Duration(milliseconds: 300),
                    ),
              ),
              SizedBox(
                height: Get.height / 2.5,
                width: Get.width,
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35.sp),
                      topLeft: Radius.circular(35.sp),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            "يسعدنا انضمامك إلى منصة تسوقي",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Text(
                          textAlign: TextAlign.justify,
                          "منصة تسوقي هي منصة لتوصيل الطلبات تقدم خدمة توصيل الطلبات من المتاجر والمطاعم والخدمات الأخرى إلى العملاء في مكان واحد.\n  يمكنك الطلب للحصول على طلباتك في الوقت المناسب. تعتمد منصة تسوقي على شبكة من السائقين المحترفين لتوصيل الطلبات، وتوفر تجربة مريحة وموثوقة للعملاء والمتاجر على حد سواء. ",
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 15.sp),
                        ),
                        20.verticalSpace,
                        const Spacer(),
                        Text(
                          "قم بانشاء حساب أو تسجيل الدخول",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.tonal(
                                onPressed: () =>
                                    Get.toNamed(AppRoutes.registerScreen),
                                child: Text("بانشاء حساب"),
                              ),
                            ),
                            20.horizontalSpace,
                            Expanded(
                              child: FilledButton.tonal(
                                onPressed: () =>
                                    Get.toNamed(AppRoutes.loginScreen),
                                child: const Text("تسجيل الدخول"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ).animate().slideY(
                    begin: 1,
                    duration: const Duration(milliseconds: 300),
                    delay: const Duration(milliseconds: 200),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
