import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddToCardComponent extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel product)? onAddProduct;
  final Function()? onSetState;
  final Function(GlobalKey key)? onAddAnimation;
  final bool showEditIcon;

  const AddToCardComponent(
      {super.key,
      required this.product,
      this.onAddProduct,
      this.showEditIcon = true,
      this.onSetState,
      this.onAddAnimation});

  @override
  State<AddToCardComponent> createState() => _AddToCardComponentState();
}

class _AddToCardComponentState extends State<AddToCardComponent> {
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final bool inCart = cartService.inCart(product: widget.product);
    return inCart
        ? buildUpdateQty(widget.product, inCart, context)
        : GestureDetector(
            onTap: () {
              cartService.addToCard(
                  context: context,
                  product: widget.product,
                  onAddAnimation: (key, status) {
                    if (status && widget.onAddAnimation != null) {
                      widget.onAddAnimation!(key);
                    }
                  });
              if (widget.onAddProduct != null) {
                widget.onAddProduct!(widget.product);
              }
              if (widget.onSetState != null) {
                widget.onSetState!();
              }
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              width: Get.width,
              height: 40.h,
              child: BlurryContainer(
                height: 50.h,
                borderRadius: BorderRadius.circular(10.sp),
                child: const Center(
                  child: Text("إضافة الى السلة "),
                ),
              ),
            ),
          );
  }

  Widget buildUpdateQty(
      ProductModel product, bool inCart, BuildContext context) {
    if (product.isShowCounter) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              cartService.increaseProductQty(product: widget.product);
              if (widget.onSetState != null) {
                widget.onSetState!();
              }
              setState(() {});
            },
            child: SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: Card(
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ).animate().scale(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Text(
              '${widget.product.isShowCounter ? cartService.getQty(product: widget.product).toInt() : cartService.getQty(product: widget.product)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              cartService.decreaseProductQty(product: widget.product);
              if (widget.onSetState != null) {
                widget.onSetState!();
              }

              setState(() {});
            },
            child: SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: Card(
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.minus,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18.sp,
                  ),
                ),
              ),
            ).animate().scale(),
          )
        ],
      );
    }
    CartItemModel item = Get.find<MainController>()
        .cart
        .firstWhere((cartItem) => cartItem.product?.id == product.id);
    return SizedBox(
      height: 40.h,
      child: inCart
          ? GestureDetector(
              onTap: () {
                cartService.addToCard(
                  product: product,
                  context: context,
                  onAddAnimation: (k, addFromOnAddAnimation) {
                    if (addFromOnAddAnimation &&
                        widget.onAddAnimation != null) {
                      widget.onAddAnimation!(k);
                    }
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                ),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(9.sp),
                  blur: 7,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.showEditIcon)
                        Icon(
                          FontAwesomeIcons.penToSquare,
                          size: 15.sp,
                        ),
                      if (widget.showEditIcon) 10.horizontalSpace,
                      AutoSizeText(
                          maxLines: 1,
                          "${item.qty} / ${item.unit!.toProductUnit()}"),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
