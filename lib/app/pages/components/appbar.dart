import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/components/safe_area_component.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:badges/badges.dart' as badges;

class AppBarComponent extends StatefulWidget {
  final bool isShowCart;
  final void Function(String)? onSearchEditingComplete;
  final void Function()? onClearSearch;
  final void Function()? onOpenDrawer;
  final String? title;
  final bool? showBackIcon;

  final TextEditingController? searchController;
  final String? hintText;

  const AppBarComponent({
    this.showBackIcon = true,
    this.searchController,
    super.key,
    this.hintText,
    this.onClearSearch,
    this.onSearchEditingComplete,
    this.isShowCart = true,
    this.onOpenDrawer,
    this.title,
  });

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  final FocusNode searchFocus = FocusNode();
  RxString searchText = RxString('');

  @override
  Widget build(BuildContext context) {
    Rxn<String> searchText = Rxn();
    return ColoredSafeArea(
      color: AppColors.scaffold,
      child: Obx(
        () => Container(
          color: AppColors.scaffold,
          width: Get.width,
          height: 53.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 50.w),
                          child: IconButton(
                            onPressed: () => Get.toNamed(AppRoutes.CART_SCREEN),
                            icon: (widget.isShowCart)
                                ? Obx(
                                    () => badges.Badge(
                                      ignorePointer: true,
                                      badgeContent: Text(
                                        "${Get.find<MainController>().cartItems.length}",
                                        style: const TextStyle(
                                            color: AppColors.scaffold),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/svg/cart.svg",
                                        fit: BoxFit.cover,
                                        color: AppColors.dark,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    child: SvgPicture.asset(
                                      "assets/svg/logo.svg",
                                      color: AppColors.warning,
                                      fit: BoxFit.contain,
                                      height: 30.h,
                                    ),
                                  ),
                          ).animate().slideX(
                                begin: 1,
                                duration: const Duration(milliseconds: 700),
                              ),
                        ),
                        if (widget.title != null)
                          Expanded(
                            child: SizedBox(
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  widget.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        if (widget.title == null)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w, right: 10.w, top: 3.h),
                              child: TextField(
                                controller: widget.searchController,
                                focusNode: searchFocus,
                                onTapOutside: (d) {
                                  if (searchFocus.hasFocus) {
                                    searchFocus.unfocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIconConstraints: BoxConstraints(
                                      maxWidth: 52, minWidth: 10.w),
                                  prefixIcon: Obx(
                                    () => (searchText.value != null &&
                                            searchText.value!.isNotEmpty)
                                        ? IconButton(
                                            onPressed: () {
                                              searchText.value = null;
                                              if (widget.onClearSearch !=
                                                  null) {
                                                widget.onClearSearch!();
                                              }
                                              if (widget.searchController !=
                                                  null) {
                                                widget.searchController!
                                                    .clear();
                                              }
                                              searchFocus.unfocus();
                                            },
                                            icon: Icon(Icons.delete,
                                                size: 20.sp,
                                                color: AppColors.warning),
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                  ),
                                  hintText: widget.hintText ?? "ابحث ..",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    borderSide: const BorderSide(
                                        color: AppColors.warning, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    borderSide: const BorderSide(
                                        color: AppColors.dark, width: 1.0),
                                  ),
                                ),
                                onChanged: (data) {
                                  searchText.value = data;
                                },
                                onEditingComplete: () {
                                  if (widget.onSearchEditingComplete != null) {
                                    widget.onSearchEditingComplete!(
                                        "${searchText.value}");
                                  }
                                  searchFocus.unfocus();
                                },
                              ),
                            ),
                          ),
                        (widget.title != null && widget.showBackIcon!)
                            ? IconButton(
                                onPressed: () => Get.back(),
                                icon: SvgPicture.asset(
                                  "assets/svg/back.svg",
                                  fit: BoxFit.cover,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  if (widget.onOpenDrawer != null) {
                                    widget.onOpenDrawer!();
                                  }
                                  Scaffold.of(context).openEndDrawer();
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/menu.svg",
                                  fit: BoxFit.cover,
                                  color: AppColors.dark,
                                  height: 15.h,
                                  width: 12.w,
                                ),
                              ).animate().slideX(
                                  duration: Duration(milliseconds: 700),
                                ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 47.h,
                child: Visibility(
                  visible: !Get.find<MainController>().option.value!.isOpen! ||
                      !(Get.find<MainController>().setting?.value.isClosed ??
                          true),
                  child: Container(
                    height: 50.h,
                    width: Get.width,
                    color: AppColors.danger.withOpacity(0.7),
                    child: Center(
                      child: Text(
                        Get.find<MainController>().option.value?.msgClose ??
                            'التطبيق مغلق',
                        style: TextStyle(
                            color: AppColors.scaffold, fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
