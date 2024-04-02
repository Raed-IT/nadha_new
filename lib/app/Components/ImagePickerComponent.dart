import 'dart:io';

import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker/hl_image_picker.dart';

class ImagePickerComponent extends StatefulWidget {
  final String? image;
  final Widget title;

  final Function(List<HLPickerItem> files) onPicked;

  ImagePickerComponent(
      {super.key, this.image, required this.title, required this.onPicked});

  @override
  State<ImagePickerComponent> createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  late List<HLPickerItem> listFiles = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickerFiles(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                widget.title,
              ],
            ),
          ),
          (widget.image != null && listFiles.isEmpty)
              ? Stack(
                  children: [
                    ImageCacheComponent(
                        fit: BoxFit.contain,
                        height: 200.h,
                        width: Get.width,
                        image: widget.image!),
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
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: 200.h,
                      width: Get.width,
                      child: Image.file(
                        File(listFiles[0].path),
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
                        onPressed: () => setState(() {
                          listFiles.clear();
                          widget.onPicked([]);
                        }),
                        icon: Icon(
                          Icons.delete,
                          size: 25.sp,
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Future pickerFiles(BuildContext context) async {
    final _picker = HLImagePicker();
    final images = await _picker.openPicker(
      pickerOptions: const HLPickerOptions(
        maxSelectedAssets: 1,
        compressFormat: CompressFormat.png,
        enablePreview: true,
        mediaType: MediaType.image,
        usedCameraButton: true,
      ),
      localized: const LocalizedImagePicker(
        doneText: "تم",
        cancelText: "الغاء",
        cropCancelText: "الغاء",
        cropDoneText: "تم",
        cropTitleText: "قص الصورة",
        okText: "تم ",
      ),
    );
    listFiles = [...images];
    widget.onPicked(listFiles);
    setState(() {});
  }
}
