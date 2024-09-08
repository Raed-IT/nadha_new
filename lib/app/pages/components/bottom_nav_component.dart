import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/components/notification_widget.dart';

import '../../them/app_colors.dart';

class BottomNavComponent extends StatefulWidget {
  const BottomNavComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavComponent> createState() => _BottomNavBarComponentState();
}

class _BottomNavBarComponentState extends State<BottomNavComponent>
    with TickerProviderStateMixin, RouteAware {
  final _mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      disableDefaultTabController: true,
      controller: _mainController.bottomNavBarController,
      top: -30.h,
      cornerRadius: 0,
      elevation: 5,
      curveSize: 68.sp,
      style: TabStyle.react,
      backgroundColor: AppColors.warning,
      onTap: (int i) => _mainController.checkIndex(i),
      items: [
        TabItem(
          isIconBlend: false,
          activeIcon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  'assets/svg/delevary.svg',
                  color: AppColors.scaffold,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text('طلباتي',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.scaffold))
            ],
          ),
          icon: SizedBox(
            height: 30.h,
            width: 30.w,
            child: SvgPicture.asset(
              'assets/svg/delevary.svg',
              color: AppColors.scaffold,
              fit: BoxFit.contain,
              height: 100.h,
            ),
          ),
        ),
        TabItem(
          isIconBlend: false,
          activeIcon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Icon(
                  FontAwesomeIcons.certificate,
                  color: AppColors.scaffold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text('العروض',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.scaffold))
            ],
          ),
          icon: SizedBox(
            height: 30.h,
            width: 30.w,
            child: Icon(
              FontAwesomeIcons.certificate,
              color: AppColors.scaffold,
              size: 22.sp,
            ),
          ),
        ),
        TabItem(
          isIconBlend: false,
          activeIcon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Icon(
                  Icons.home_outlined,
                  color: AppColors.scaffold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text('الرئيسة',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.scaffold))
            ],
          ),
          icon: Icon(
            Icons.home_outlined,
            color: AppColors.scaffold,
            size: 22.sp,
          ),
        ),

      ],
    );
  }
}
