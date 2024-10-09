import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreSpecialComponent extends GetView<HomeScreenController> {
  const StoreSpecialComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "متاجر موصى بها",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildCard();
            },
          ),
        )
      ],
    );
  }

  Widget _buildCard() {
    return Container();
  }
}
