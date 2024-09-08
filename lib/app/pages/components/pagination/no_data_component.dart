import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataMorComponent extends StatelessWidget {
  const NoDataMorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لايوجد مزيد من البيانات ",
                style: TextStyle(fontSize: 15.sp),
              )
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
