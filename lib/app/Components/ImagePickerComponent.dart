import 'dart:io';

import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ImagePickerComponent extends StatefulWidget {
  final String? image;
  final Widget title;
  FilePickerResult? result;
  final Function(List<PlatformFile> files) onPicked;

   ImagePickerComponent(
      {super.key, this.image, required this.title, required this.onPicked});

  @override
  State<ImagePickerComponent> createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {
        widget.result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'doc'],
        );
        if (        widget.result != null &&         widget.result!.files.isNotEmpty) {
          widget.onPicked(        widget.result!.files);
        }
        setState(() {});
      },
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
          (        widget.result != null &&         widget.result!.files.isNotEmpty)
              ? Stack(
                  children: [
                    SizedBox(
                      height: 200.h,
                      width: Get.width,
                      child: Image.file(
                        File(        widget.result!.files.first.path!),
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
                          widget.result!.files.clear();
                          widget.onPicked([]);
                        }),
                        icon: Icon(
                          Icons.delete,
                          size: 25.sp,
                        ),
                      ),
                    )
                  ],
                )
              :( widget.image != null && widget.image!.isNotEmpty)
                  ? Stack(
                      children: [
                        SizedBox(
                          height: 200.h,
                          width: Get.width,
                          child: Image.network("${widget.image}"),
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
                              widget.result!.files.clear();
                              widget.onPicked([]);
                            }),
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
                        (widget.image != null && widget.image!.isNotEmpty)
                            ? ImageCacheComponent(
                                fit: BoxFit.contain,
                                height: 200.h,
                                width: Get.width,
                                image: widget.image!)
                            : Container(
                                height: 200.h,
                                child: Center(
                                  child: Text(
                                    "اضغط لإختيار صورة",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
  }
}
