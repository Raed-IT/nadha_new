import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioWithLabelComponent<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final void Function(T?)? onChanged;

  const RadioWithLabelComponent(
      {super.key,
      required this.value,
      this.groupValue,
      required this.label,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(label,style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 12.sp,color: onChanged!=null?null:AppColors.highLightColor
        ),),
      ],
    );
  }
}
