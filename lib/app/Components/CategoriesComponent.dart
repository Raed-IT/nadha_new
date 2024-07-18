import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Route/Routs.dart';
import '../Screens/CategoriesScreen/CategoriesScreenController.dart';

class CategoriesComponent extends StatelessWidget {
  final RxBool isLoading;
  List<CategoryModel> categories;
  final int? storeId;

  CategoriesComponent(
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
              color: Theme.of(context).colorScheme.background,
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
              () => categories.isNotEmpty
                  ? Column(
                      children: [
                        AnimatedContainer(
                          duration: 10.ms,
                          child: Card(
                            color: Theme.of(context).colorScheme.background,
                            elevation: 0,
                            child: GridView.count(
                              semanticChildCount: 10,
                              physics: isExpanded.value
                                  ? const BouncingScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 6,
                              childAspectRatio: 1 / 1.5,
                              children: categories
                                  .take(
                                      !isExpanded.value ? 6 : categories.length)
                                  .map(
                                    (c) => GestureDetector(
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
                                          Get.toNamed(
                                              AppRoutes.categoryProducts,
                                              arguments: {
                                                "category": c,
                                                "store_id": storeId
                                              });
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Hero(
                                              tag: "categories${c.id}",
                                              child:
                                                  // SvgPicture.network("${c.image}" ,width: 100,height: 100,)
                                                  ImageCacheComponent(
                                                width: 50.w,
                                                height: 50.h,
                                                image: "${c.image}",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Hero(
                                              tag: "categories_text${c.id}",
                                              flightShuttleBuilder:
                                                  (BuildContext flightContext,
                                                          Animation<double>
                                                              animation,
                                                          HeroFlightDirection
                                                              flightDirection,
                                                          BuildContext
                                                              fromHeroContext,
                                                          BuildContext
                                                              toHeroContext) =>
                                                      Material(
                                                          child: toHeroContext
                                                              .widget),
                                              child: AutoSizeText(
                                                "${c.name}",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
                            ? Transform.translate(
                                offset: Offset(0, -20.h),
                                child: GestureDetector(
                                  onTap: () {
                                    isExpanded.value = !isExpanded.value;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        // if (!isExpanded.value)
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.1),
                                        //     spreadRadius: 3,
                                        //     blurRadius: 3,
                                        //     offset: Offset(0,
                                        //         3), // changes position of shadow
                                        //   ),
                                      ],
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    padding: EdgeInsets.all(5.sp),
                                    margin: EdgeInsets.only(
                                        top: 0,
                                        bottom: isExpanded.value ? 0 : 10.h),
                                    child: Icon(
                                      size: 30.sp,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      !isExpanded.value
                                          ? FontAwesomeIcons.ellipsis
                                          : FontAwesomeIcons.ellipsis,
                                    ).animate(onComplete: (cont) {
                                      // cont.repeat();
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
                    )
                  : SizedBox(
                      height: 50.h,
                      child: Center(
                        child: Text(
                          'لايوجد فئات ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ),
    );
  }
}
