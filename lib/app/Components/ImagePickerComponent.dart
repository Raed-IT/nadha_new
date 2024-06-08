import 'dart:io';

import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Rxn<FilePickerResult> result = Rxn();

class ImagePickerComponent extends StatelessWidget {
  final String? image;
  final Widget title;
  final void Function(List<PlatformFile> files) onPicked;

  ImagePickerComponent(
      {super.key, this.image, required this.title, required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () async {
            result.value = await FilePicker.platform.pickFiles(
              type: FileType.image,
            );
            if (result.value != null && result.value!.files.isNotEmpty) {
              Logger()
                  .w(result.value != null && result.value!.files.isNotEmpty);
              onPicked(result.value!.files);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  children: [
                    title,
                  ],
                ),
              ),
              (result.value != null && result.value!.files.isNotEmpty)
                  ? Stack(
                      children: [
                        SizedBox(
                          height: 200.h,
                          width: Get.width,
                          child: Image.file(
                            File(result.value!.files.first.path!),
                          ),
                        ),
                        Container(
                          height: 200.h,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            gradient: const LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              result.value = null;
                              onPicked([]);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 25.sp,
                            ),
                          ),
                        )
                      ],
                    )
                  : (image != null && image!.isNotEmpty)
                      ? Stack(
                          children: [
                            SizedBox(
                              height: 200.h,
                              width: Get.width,
                              child: Image.network("${image}"),
                            ),
                            Container(
                              height: 200.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                gradient: const LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [Colors.transparent, Colors.black54],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  result.value!.files.clear();
                                  onPicked([]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 25.sp,
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            (image != null && image!.isNotEmpty)
                                ? ImageCacheComponent(
                                    fit: BoxFit.contain,
                                    height: 200.h,
                                    width: Get.width,
                                    image: image!)
                                : Container(
                                    height: 200.h,
                                    child: Center(
                                      child: Text(
                                        "اضغط لإختيار صورة",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                            Container(
                              height: 200.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                gradient: const LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [Colors.transparent, Colors.black54],
                                ),
                              ),
                            )
                          ],
                        ),
            ],
          ),
        );
      },
    );
  }
}
