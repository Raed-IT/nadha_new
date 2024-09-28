import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesComponent extends StatelessWidget {
  final RxBool isLoading;
  List<CategoryModel> categories;
  final int? storeId;

  CategoriesComponent(
      {super.key,
      required this.categories,
      required this.isLoading,
      this.storeId});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
