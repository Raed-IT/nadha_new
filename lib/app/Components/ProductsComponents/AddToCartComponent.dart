import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class AddToCardComponent extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel product)? onAddProduct;
  final Function()? onSetState;

  const AddToCardComponent(
      {super.key, required this.product, this.onAddProduct, this.onSetState});

  @override
  State<AddToCardComponent> createState() => _AddToCardComponentState();
}

class _AddToCardComponentState extends State<AddToCardComponent> {
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return (cartService.inCart(product: widget.product))
        ? buildUpdateQty(widget.product)
        : GestureDetector(
            onTap: () {
              cartService.addToCard(
                context: context,
                product: widget.product,
              );
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
    TextEditingController textEditingController = TextEditingController(
        text: "${cartService.getQty(product: widget.product)}");

    double qty = 0;
    return Expanded(
      child: SizedBox(
        height: 30.h,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                double? qty =
                    cartService.increaseProductQty(product: widget.product);
                if (qty != null) {
                  textEditingController.text = "$qty";
                }
                if (widget.onSetState != null) {
                  widget.onSetState!();
                }
                setState(() {});
              },
              child: SizedBox(
                width: 25.sp,
                height: 20.sp,
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ).animate().scale(),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (data) {
                  if (double.tryParse(data) == null) {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: "الرجاء كتابة رقم صحيح",
                        gravity: ToastGravity.TOP);
                    return;
                  }
                  qty = double.parse(data);
                },
                onEditingComplete: () {
                  if (qty > 0) {
                    cartService.addCustomQty(product: product, qty: qty);
                  } else {
                    Fluttertoast.showToast(
                        msg: "الرجاء اختيار قيمة اكبر من الصفر");
                  }
                  FocusScope.of(context).unfocus();
                },
                controller: textEditingController,
                validator: (data) {
                  Logger().w(double.tryParse("$data"));
                  if (double.tryParse("$data") == null) {
                    // Fluttertoast.cancel();
                    Fluttertoast.showToast(msg: "الرجاء ادخال رقم صحيح");
                  }
                  return null;
                },
                style: TextStyle(fontSize: 10.sp),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.primary.withOpacity(
                                  0.2,
                                ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.secondary.withOpacity(
                                  0.5,
                                ),
                      ),
                    )),
                // controller: TextEditingController(),
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
                width: 25.sp,
                height: 20.sp,
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.minus,
                    size: 15.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ).animate().scale(),
            ),
          ],
        ),
      ),
    );
  }
}
