import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

class SearchFieldComponent extends GetView<SearchScreenController> {
  const SearchFieldComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10.sp),
          color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => controller.search(context),
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: TextField(
              onSubmitted: (da) {
                controller.search(context);
              },
              autofocus: true,
              onChanged: (data) => controller.searchText.value = data,
              controller: controller.searchTextController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Obx(
            () => (controller.searchText.value.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      controller.searchTextController.clear();
                      controller.searchText.value = '';
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 18.sp,
                    ),
                  ).animate().scale(duration: 500.ms, curve: Curves.elasticOut)
                : Container(),
          )
          // IconButton(
          //   onPressed: () =>
          //       showSearchFilterBottomSheet(),
          //   icon: Icon(
          //     FontAwesomeIcons.filter,
          //     size: 17.sp,
          //     color:
          //         Theme.of(context).colorScheme.primary,
          //   ),
          // ),
        ],
      ),
    );
  }
}
