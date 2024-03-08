import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CategoryProductsScreen/CategoryProductsScreenController.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Components/AppBarComponents/AppBarComponent.dart';

class CategoryProductsScreen extends GetView<CategoryProductsScreenController> {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      body: Builder(
          builder: (context) => Stack(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ListView(
                        children: [
                          220.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: ProductListComponent(
                              onProductTap: (ProductModel product,k) {
                                Get.toNamed(AppRoutes.showProduct,
                                    preventDuplicates: false,
                                    arguments: {"product": product});
                                Get.put(ShowProductScreenController(),
                                    tag: "show_product${product.id}");
                              },
                              products: controller.products,
                              isLoad: controller.isLoad,
                            ),
                          ),
                        ],
                      ),
                      Hero(
                        tag: "categories${controller.category.id}",
                        child: ImageCacheComponent(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.sp),
                            bottomLeft: Radius.circular(15.sp),
                          ),
                          width: Get.width,
                          height: 200.h,
                          image: "${controller.category.image}",
                        ),
                      ),
                      Positioned(
                        top: 160.h,
                        child: SizedBox(
                          width: Get.width,
                          height: 70.h,
                          child: Card(
                            margin: EdgeInsets.symmetric(horizontal: 30.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius:
                                          BorderRadius.circular(100.sp)),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  height: 50.sp,
                                  width: 50.sp,
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.layerGroup,
                                      size: 20.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    "${controller.category.name}",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).animate().show().slideY(
                            begin: 1,
                            duration: const Duration(milliseconds: 500)),
                      )
                    ],
                  ),
                  AppBarComponent(
                    openDrawer: () => Scaffold.of(context).openDrawer(),
                  ),
                ],
              )),
    );
  }
}
