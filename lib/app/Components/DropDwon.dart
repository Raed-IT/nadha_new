import 'package:delevary/app/Data/Models/BaseModel.dart';
import 'package:delevary/app/Thems/ColorSchemes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DropDownComponent<T extends BaseModel> extends StatelessWidget {
  final double? width;
  final double? overLayPadding;
  final List<T> items;
  final String title;

  final Function(T item) onSelected;

  const DropDownComponent(
      {super.key,
      this.width,
      this.overLayPadding,
      required this.items,
      required this.onSelected,
      required this.title});

  @override
  Widget build(BuildContext context) {
    Rxn<T> selectedItem = Rxn();
    ColorScheme currentColorScheme =
        context.isDarkMode ? darkColorScheme : lightColorScheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        value: null,
        onChanged: (value) {},
        buttonStyleData: ButtonStyleData(
          height: 60.h,
          decoration: BoxDecoration(
            color: currentColorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          padding: const EdgeInsets.only(left: 14, right: 14),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            size: 15.sp,
            Icons.arrow_forward_ios_outlined,
            color: currentColorScheme.primary,
          ),
          iconSize: 14.sp,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: Get.height / 4,
          width: width ?? Get.width,
          padding: EdgeInsets.all(overLayPadding ?? 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          offset: Offset(-40.h, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40.h,
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                onTap: () {
                  selectedItem.value = item;
                  onSelected(item);
                },
                child: Text("${item.getTitle()}"),
              ),
            )
            .toList(),
      ),
    );
  }
}
