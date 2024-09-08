import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nadha/app/them/app_colors.dart';

class ImageCacheComponent extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;

  const ImageCacheComponent(
      {required this.image, super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: height,
        width: width,
        alignment: Alignment.center,
        progressIndicatorBuilder: (context, string, progress) {
          return SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: CardLoading(
                    height: height ?? Get.height,
                    cardLoadingTheme: CardLoadingTheme(
                        colorOne: AppColors.warning.withOpacity(0.5),
                        colorTwo: Colors.black26),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: SvgPicture.asset(
                          "assets/svg/logo.svg",
                          fit: BoxFit.contain,
                          color: AppColors.warning,
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
              ],
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
    );
  }
}
