import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

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
        child: FastCachedImage(
          url: image,
          cacheHeight: 290.sp.toInt(),
          cacheWidth: 290.sp.toInt(),
          fit: fit??BoxFit.contain,
          width: width,
          height: height,
          loadingBuilder: (context, progress) {
            return Material(
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Opacity(
                        opacity: 0.2,
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Image.asset("assets/images/loader.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                          maxLines: 1,
                          "${ progress.progressPercentage.value==0?'':progress.progressPercentage.value} %"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
/*
CachedNetworkImage(
          color: imageColor,
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          alignment: Alignment.center,
          progressIndicatorBuilder: (context, string, progress) {
            return Material(
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Opacity(
                        opacity: 0.2,
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Image.asset("assets/images/loader.png"),
                        ),
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
        )

* */
