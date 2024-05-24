import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/Api/FavoretService.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/ApiRoute.dart';

class ProductCardComponent extends StatefulWidget {
  final ProductModel product;
  final Function(GlobalKey kye) onTap;
  final BorderRadius? imageRadius;
  final String? heroTagPrefix;
  final Function(ProductModel product, GlobalKey key) onTapAddProduct;
  final Function(ProductModel product)? onRemoveProductFromFavorite;

  ProductCardComponent(
      {super.key,
      required this.product,
      required this.onTap,
      this.imageRadius,
      this.heroTagPrefix,
      required this.onTapAddProduct,
      this.onRemoveProductFromFavorite});

  @override
  State<ProductCardComponent> createState() => _ProductCardComponentState();
}

class _ProductCardComponentState extends State<ProductCardComponent> {
  final GlobalKey productKey = GlobalKey();

  final FavoriteService favoriteService = FavoriteService();
  bool isTrregierFavorite = false;
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    Get.find<MainController>().cart.listen((p0) {
      if (mounted) setState(() {});
    });
    final GlobalKey productCardKye = GlobalKey();
    return GestureDetector(
      onTap: () {
        if ((widget.product.store?.isOpen ?? false)) {
          widget.onTap(productCardKye);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            width: _cartService.inCart(product: widget.product) ? 3.sp : 2.sp,
            color: _cartService.inCart(product: widget.product)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: BlurryContainer(
          blur: 10,
          borderRadius: BorderRadius.circular(10.sp),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 160.h,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Hero(
                                tag:
                                    "${widget.heroTagPrefix ?? 'product_image_'}${widget.product.id}",
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: widget.imageRadius ??
                                        BorderRadius.circular(10.sp),
                                  ),
                                  child: ImageCacheComponent(image: "${widget.product.image}",),
                                  /*

                                   Container(
                                    key: productCardKye,
                                    child: ImageCacheComponent(
                                      height: 160.h,
                                      fit: BoxFit.cover,
                                      borderRadius: widget.imageRadius ??
                                          BorderRadius.circular(10.sp),
                                      image: "${widget.product.image}",
                                    ),
                                  )
                                  */
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 30.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                              ),
                              gradient: const LinearGradient(
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent]),
                            ),
                            child: Center(
                              child: Text(
                                "${widget.product.store?.name}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              widget.onTapAddProduct(
                                  widget.product, productCardKye);
                            },
                            child: SizedBox(
                              height: 35.sp,
                              width: 35.sp,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Center(
                                  child: Icon(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    FontAwesomeIcons.plus,
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isTrregierFavorite = true;
                              });
                              bool status =
                                  await favoriteService.favoriteTrigger(
                                      product: widget.product,
                                      context: context);
                              setState(() {
                                if (status) {
                                  if (widget.product.isFavorite! &&
                                      widget.onRemoveProductFromFavorite !=
                                          null) {
                                    widget.onRemoveProductFromFavorite!(
                                        widget.product);
                                  }
                                  widget.product.isFavorite =
                                      !widget.product.isFavorite!;
                                }
                                isTrregierFavorite = false;
                              });
                            },
                            child: SizedBox(
                              height: 35.sp,
                              width: 35.sp,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: !isTrregierFavorite
                                    ? Center(
                                        child: Icon(
                                          size: 16.sp,
                                          (widget.product.isFavorite!)
                                              ? Icons.favorite
                                              : FontAwesomeIcons.heart,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      )
                                    : SizedBox(
                                        height: 25.sp,
                                        width: 25.sp,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.sp),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 03.sp,
                                          ),
                                        )),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60.h,
                          child: GestureDetector(
                            onTap: () {
                              Share.share(
                                  '${widget.product.name}\n\n\n${ApiRoute.domin}/products/${widget.product.slug}');
                            },
                            child: SizedBox(
                              height: 35.sp,
                              width: 35.sp,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.shareNodes,
                                  size: 15.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (!(widget.product.store?.isOpen ?? false))
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 160.h,
                        width: Get.width,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        child: Center(
                          child: Text(
                            "المتجر مغلق",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  "${widget.product.name} ",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  "${widget.product.info}",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BuildPriceProductComponent(
                          product: Rx(widget.product),
                        ),
                      ),
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
}
