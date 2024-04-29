import 'package:delevary/app/Data/Models/BaseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class DropDownComponent<T extends BaseModel> extends StatelessWidget {
  final String? searchHintText;
  final String hintText;
  final List<T> items;
  final T? initVal;
  final BorderRadius? borderRadius;
  final Function(T? item) onSelected;

  const DropDownComponent(
      {super.key,
      this.searchHintText,
      required this.items,
      required this.onSelected,
      this.initVal,
      required this.hintText,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    late SearchableDropdownController<T> controller;

    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: borderRadius ?? BorderRadius.circular(15.sp),
          color: Theme.of(context).colorScheme.onPrimary),
      child: SearchableDropdown<T>(
        controller: (initVal != null)
            ? SearchableDropdownController(
                initialItem: SearchableDropdownMenuItem(
                  label: '${initVal?.getTitle()}',
                  child: Text("${initVal?.getTitle()}"),
                ),
              )
            : null,
        searchHintText: searchHintText ?? "ابحث ....",
        hintText: Text(hintText),
        margin: const EdgeInsets.all(15),
        onChanged: (T? item) {
          onSelected(item);
        },
        items: items
            .map(
              (item) => SearchableDropdownMenuItem(
                value: item,
                label: '${item.getTitle()}',
                child: Text('${item.getTitle()}'),
              ),
            )
            .toList(),
      ),
    );
  }
}
