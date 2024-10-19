import 'package:delevary/app/Components/AppBarComponents/v2/appBar/appbar_with_title.dart';
import 'package:delevary/app/Components/v2/address_list_component/address_list_component.dart';
import 'package:delevary/app/Components/v2/primary_button.dart';
import 'package:delevary/app/Components/v2/radio_with_label_component.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/checkout_screen/checkout_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutScreen extends GetView<CheckoutScreenController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarWithTitleComponent(title: "الدفع"),
          40.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AddressListComponent(
                    label: "العنوان",
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Text(
                      "طريقة الدفع",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RadioWithLabelComponent(
                          value: 1,
                          groupValue: 1,
                          label: "عند الاستلام",
                          onChanged: (d) {},
                        ),
                        RadioWithLabelComponent(value: 2, label: "تطبيق"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: PrimaryButtonComponent(
                      label: "إرسال الطلب",
                      onTap: () async => Get.toNamed(AppRoutes.orderComplete,
                          arguments: {"orderId": 5}),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
