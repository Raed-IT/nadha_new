import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchFiledComponent extends StatefulWidget {
  final RxBool isLoad;
  final Function(String) onChanged;
  final Function() onEditingComplete;

  const SearchFiledComponent(
      {super.key,
      required this.isLoad,
      required this.onChanged,
      required this.onEditingComplete});

  @override
  State<SearchFiledComponent> createState() => _SearchFiledComponentState();
}

class _SearchFiledComponentState extends State<SearchFiledComponent> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.sp),
      borderSide: BorderSide(
        color: AppColors.highLightColor,
      ),
    );
    return Obx(
      () => widget.isLoad.value
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CardLoadingComponent(
                opacity: 0.8,
                borderRadius: BorderRadius.circular(10.sp),
                height: 40.h,
                width: Get.width,
              ),
            )
          : Padding(
              padding: EdgeInsets.all(20.sp),
              child: TextField(
                controller: controller,
                onEditingComplete: () {
                  widget.onEditingComplete();
                  FocusScope.of(context).unfocus();
                },
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: "بحث .. ",
                  hintStyle: TextStyle(
                    color: AppColors.highLightColor,
                  ),
                  suffixIcon: controller.text.isEmpty
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () {
                            controller.clear();
                            widget.onChanged('');
                            widget.onEditingComplete();
                          },
                          icon: const Icon(Icons.close),
                        ).animate().scale(),
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    size: 18.sp,
                    color: AppColors.highLightColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  enabledBorder: border,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
    );
  }
}
