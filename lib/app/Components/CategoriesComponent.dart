import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../Route/Routs.dart';
import '../Screens/CategoriesScreen/CategoriesScreenController.dart';

class CategoriesComponent extends StatelessWidget {
  final RxBool isLoading;
  final List<CategoryModel> categories;
  final int? storeId;

  const CategoriesComponent(
      {super.key,
      required this.categories,
      required this.isLoading,
      this.storeId});

  @override
  Widget build(BuildContext context) {
    RxBool isExpanded = RxBool(true);
    GlobalKey gridViewKey = GlobalKey();
    return Obx(
      () => isLoading.value
          ? Card(
              margin: EdgeInsets.only(top: 20.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.sp),
              ),
              child: GridView.count(
                key: gridViewKey,
                shrinkWrap: true,
                crossAxisCount: 6,
                childAspectRatio: 1 / 1.1,
                children: List.generate(6, (index) => index)
                    .map(
                      (e) => CardLoadingComponent(
                        cardMargin: EdgeInsets.all(5.sp),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          : Obx(
              () => Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: 10.ms,
                    height: isExpanded.value
                        ? 150.sp
                        : gridViewKey.currentContext?.size?.height,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.only(top: 20.h,bottom: isExpanded.value ? 0 : 30.h),
                      child: GridView.count(
                        semanticChildCount: 10,
                        physics: !isExpanded.value
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 6,
                        childAspectRatio: 1 / 1.5,
                        children: categories
                            .map(
                              (c) => InkWell(
                                onTap: () {
                                  if (c.hasChildren!) {
                                    Get.toNamed(
                                      AppRoutes.categories,
                                      arguments: {
                                        "category": c,
                                      },
                                    );
                                    Get.put(CategoriesScreenController(),
                                        tag: "category${c.id}");
                                  } else {
                                    Get.toNamed(AppRoutes.categoryProducts,
                                        arguments: {
                                          "category": c,
                                          "store_id": storeId
                                        });
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Hero(
                                        tag: "categories${c.id}",
                                        child: ImageCacheComponent(
                                          width: 50.w,
                                          height: 50.h,
                                          image: "${c.image}",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: AutoSizeText(
                                        "${c.name}",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  categories.length > 6
                      ? Positioned(
                          bottom: -20.h,
                          right: 0,
                          left: 0,
                          child: Container(
                            margin: EdgeInsets.only(bottom: isExpanded.value ? 0 : 10.h),
                            color: !isExpanded.value
                                ? Theme.of(context).cardColor
                                : null,
                            child: IconButton(
                              onPressed: () {
                                isExpanded.value = !isExpanded.value;
                              },
                              icon: Icon(
                                size: 20.sp,
                                isExpanded.value
                                    ? FontAwesomeIcons.chevronDown
                                    : FontAwesomeIcons.chevronUp,
                              ).animate(onComplete: (cont) {
                                cont.repeat();
                              }).scale(
                                  begin: const Offset(.7, .7),
                                  end: const Offset(1, 1),
                                  curve: Curves.elasticInOut,
                                  alignment: Alignment.center,
                                  duration: 3000.ms),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
    );
  }
}
