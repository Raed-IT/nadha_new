import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/enums/order_status_enum.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/order_model.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:dio/dio.dart' as dio;

Future<OrderModel?> showOrderStateBottomSheet(
    {required Rx<OrderModel> order,
    required BuildContext context,
    required Function(OrderModel order) onSaved,
    List<UserModel> users = const []}) async {
  OrderModel? orderModel;
  await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
        ),
      ),
      context: context,
      builder: (context) {
        return Obx(() {
          if (order.value.statusEn == "pending") {
            return buildChangeDriverWidget(
                order: order, onSaved: onSaved, users: users);
          }
          return buildChangeStatusWidget(order: order, onSaved: onSaved);
        });
      });
  return orderModel;
}

Widget buildChangeDriverWidget(
    {required Rx<OrderModel> order,
    required Function(OrderModel order) onSaved,
    List<UserModel> users = const []}) {
  Rxn<UserModel> currentDriver = Rxn();
  return Container(
    padding: EdgeInsets.all(10.sp),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
      color: AppColors.fill,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => DropdownButton<UserModel>(
            menuMaxHeight: 400.h,
            padding: EdgeInsets.symmetric(vertical: 5.h),
            focusColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: users.map<DropdownMenuItem<UserModel>>((UserModel user) {
              return DropdownMenuItem<UserModel>(
                value: user,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    "${user.name}",
                    style: const TextStyle(color: AppColors.dark),
                  ),
                ),
              );
            }).toList(),
            underline: Container(),
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.dark.withOpacity(0.5),
              ),
            ),
            isExpanded: true,
            hint: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: const Text("الرجاء اختيار السائق"),
            ),
            value: currentDriver.value,
            onChanged: (value) {
              currentDriver.value = value;
            },
          ),
        ),
        SizedBox(
          height: 40.h,
          width: Get.width,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            color: AppColors.dark,
            onPressed: () async {
              await changeOrderStatus(order.value.id!, order.value.statusEn!,
                  (p0) => onSaved(p0), currentDriver.value?.id);
            },
            child: Text(
              "حفظ حالة الطلب ",
              style: TextStyle(fontSize: 15.sp, color: AppColors.scaffold),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildChangeStatusWidget(
    {required Rx<OrderModel> order,
    required Function(OrderModel order) onSaved}) {
  RxString radio = RxString("${order.value.statusEn}");
  return Obx(
    () => Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...OrderStatus.values.map((e) {
            if (order.value.statusEn == e.name) {
              return Container();
            }

            return GestureDetector(
              onTap: () {
                radio.value = e.name;
              },
              child: Row(
                children: [
                  Radio(
                      activeColor: AppColors.warning,
                      value: e.name,
                      groupValue: radio.value,
                      onChanged: (data) {
                        radio.value = data!;
                      }),
                  Text(e.toOrderStatusLabel()),
                ],
              ),
            );
          }).toList(),
          SizedBox(
            height: 40.h,
            width: Get.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              color: AppColors.dark,
              onPressed: () async {
                changeOrderStatus(
                    order.value.id!, radio.value, (p0) => onSaved(p0), null);
              },
              child: Text(
                "حفظ حالة الطلب ",
                style: TextStyle(fontSize: 15.sp, color: AppColors.scaffold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> changeOrderStatus(
    int id, String status, Function(OrderModel) onSaved, int? driverId) async {
  Get.back();
  EasyLoading.show();
  dio.Dio dioRequest = dio.Dio();
  dioRequest.options.headers["Content-Type"] = "application/json";
  dioRequest.options.headers["authorization"] =
      "Bearer ${Get.find<MainController>().token}";
  dio.Response response =
      await dioRequest.post("${ApiRouts.orders}/$id", data: {
    "_method": "PUT",
    "status": status,
    if (driverId != null) "driver": driverId,
  });

  if (response.statusCode == 200 && response.data != null) {
    Logger().w(response.data['data']['order']);
    onSaved(OrderModel.fromJson(response.data['data']['order']));
  }
  EasyLoading.dismiss();
}
