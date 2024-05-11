import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Enums/AcceptedProductEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Products/Components/DeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BuildStoreProductCardComponent extends StatelessWidget {
  final ProductModel product;
  final Future<bool> Function(ProductModel product, bool status) onChangeStatus;
  final Function(ProductModel product) onUpdateProduct;
  final Function(ProductModel product) onDeleteProduct;

  const BuildStoreProductCardComponent({
    super.key,
    required this.product,
    required this.onChangeStatus,
    required this.onUpdateProduct,
    required this.onDeleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    RxBool status = RxBool(product.status ?? false);
    RxBool isUpdate = RxBool(false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: BlurryContainer(
          blur: 7,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100.sp,
                    width: 120.sp,
                    child: Stack(
                      children: [
                        ImageCacheComponent(
                          borderRadius: BorderRadius.circular(10.sp),
                          image: "${product.image}",
                          height: 100.sp,
                          width: 120.sp,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                              ),
                              gradient: LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: getColor(context),
                              ),
                            ),
                            width: 120.sp,
                            child: AutoSizeText(
                              textAlign: TextAlign.center,
                              "${product.isAccepted?.toAcceptedProductName()}",
                              maxLines: 1,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${product.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        10.verticalSpace,
                        AutoSizeText(
                          "${product.info}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
                child: Obx(
                  () => Row(
                    children: [
                      (!isUpdate.value)
                          ? SizedBox(
                              width: 55.w,
                              child: FittedBox(
                                child: Switch(
                                  value: status.value,
                                  onChanged: (state) async {
                                    isUpdate.value = true;
                                    bool isUpdaated =
                                        await onChangeStatus(product, state);
                                    if (isUpdaated) {
                                      status.value = !status.value;
                                      product.status = status.value;
                                    }
                                    isUpdate.value = false;
                                  },
                                ),
                              ),
                            )
                          : Lottie.asset("assets/json/loader.json"),
                      5.horizontalSpace,
                      Text(
                        status.value ? 'مفعل' : 'غير مفعل ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var updatedProduct = await Get.toNamed(
                                  AppRoutes.updateProduct,
                                  arguments: {"product": product});
                              if (updatedProduct != null) {
                                onUpdateProduct(updatedProduct);
                              }
                            },
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.pen,
                                    size: 12.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showDeleteProductDialog(
                                onDelete: onDeleteProduct,
                                context: context,
                                product: product),
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    size: 20.sp,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Color> getColor(BuildContext context) {
    return [
      if (product.isAccepted == AcceptedProductEnum.pending.name) ...[
        Theme.of(context).colorScheme.secondary,
        Theme.of(context).colorScheme.secondary.withOpacity(0.5)
      ],
      if (product.isAccepted == AcceptedProductEnum.accepted.name) ...[
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primary.withOpacity(0.5)
      ],
      if (product.isAccepted == AcceptedProductEnum.rejected.name) ...[
        Colors.red,
        Colors.red.withOpacity(0.5)
      ]
    ];
  }
}
