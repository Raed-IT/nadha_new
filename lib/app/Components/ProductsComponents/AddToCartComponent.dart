import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddToCardComponent extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel product)? onAddProduct;
  final Function()? onSetState;
  final Function(GlobalKey key)? onAddAnimation;

  const AddToCardComponent(
      {super.key,
      required this.product,
      this.onAddProduct,
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
        ? buildUpdateQty(widget.product)
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
            child: Card(
              elevation: 5,
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: SizedBox(
                height: 40.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Center(
                    child: Text(
                      "اضافة الى السلة",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ).animate().scale(
                  begin: const Offset(0, 0),
                ),
          );
  }

  Widget buildUpdateQty(ProductModel product) {
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
    return Expanded(
      child: SizedBox(
        height: 30.h,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.penToSquare,
              size: 15.sp,
            ),
            // Text("${widget.}")
          ],
        ),
      ),
    );
  }
}
