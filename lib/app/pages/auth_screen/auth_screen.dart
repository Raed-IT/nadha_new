import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nadha/app/pages/auth_screen/auth_controller.dart';
import 'package:nadha/app/pages/auth_screen/components/register_component.dart';

import '../../them/app_colors.dart';
import '../components/clippath/login_canvas.dart';
import '../components/clippath/register_canvas.dart';
import 'components/login_component.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isShowLogin = true;
  AuthScreenController controller = Get.find<AuthScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1, 0.8),
                colors: AppColors.mainGradient,
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              "assets/images/App-home.png",
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: (isShowLogin) ?80.h:10.h,
                    ),

                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      height: 85.h,
                      color: AppColors.scaffold,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowLogin = true;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.sp),
                            ),
                            child: ClipPath(
                              clipper: LoginClipper(),
                              child: Container(
                                height: 50.h,
                                width: 150.w,
                                color: AppColors.scaffold,
                                child: Center(
                                  child: Text(
                                    "تسجيل الدخول  ",
                                    style: TextStyle(
                                        color: (isShowLogin)
                                            ? AppColors.warning
                                            : AppColors.dark,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                                  () {
                                isShowLogin = false;
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.sp),
                            ),
                            child: ClipPath(
                              clipper: RegisterClipper(),
                              child: Container(
                                height: 50.h,
                                width: 150.w,
                                color: AppColors.scaffold,
                                child: Center(
                                  child: Text(
                                    "تسجيل جديد ",
                                    style: TextStyle(
                                        color: (!isShowLogin)
                                            ? AppColors.warning
                                            : AppColors.dark,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: isShowLogin,
                          child: LoginComponent(),
                        ),
                        Visibility(
                          visible: !isShowLogin,
                          child: RegisterComponent(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
