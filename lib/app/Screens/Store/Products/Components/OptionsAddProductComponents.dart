import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OptionsAddProductComponent extends StatelessWidget {
  final String title;
  final String initVal;
  final Function(String val) onChange;
  final Map<String, dynamic> values;

  const OptionsAddProductComponent(
      {super.key,
      required this.title,
      required this.onChange,
      required this.initVal,
      required this.values});

  @override
  Widget build(BuildContext context) {
    RxString val = RxString(initVal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        10.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: values.keys
              .map(
                (kye) => GestureDetector(
                  onTap: () {
                    onChange(kye);
                    val.value = kye;
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: kye,
                            groupValue: val.value,
                            onChanged: (cval) {
                              val.value = cval!;
                              onChange(kye);
                            }),
                      ),
                      Text(values[kye]),
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
