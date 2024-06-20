import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageCacheComponent extends StatelessWidget {
  final String image;
  final Color? imageColor;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ImageCacheComponent(
      {required this.image,
      super.key,
      this.height,
      this.width,
      this.borderRadius,
      this.imageColor,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          color: imageColor,
          fit: fit ?? BoxFit.cover,
          memCacheHeight: 400.sp.toInt(),
          memCacheWidth: 400.sp.toInt(),
          height: height,
          width: width,
          alignment: Alignment.center,
          progressIndicatorBuilder: (context, string, progress) {
            return Material(
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: CardLoading(
                        height: height ?? Get.height,
                        cardLoadingTheme: CardLoadingTheme(
                            colorOne: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            colorTwo: Colors.black26),
                        borderRadius: borderRadius ??
                            BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Image.asset("assets/images/loader.png"),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                                maxLines: 1,
                                "${((progress.progress ?? 0) * 100).toStringAsFixed(2)} %"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          imageUrl: image,
          errorWidget: (context, s, r) {
            return Center(
              child: Icon(
                Icons.error_outline,
                size: 50.sp,
              ),
            );
          },
        ),
      ),
    );
  }
}
