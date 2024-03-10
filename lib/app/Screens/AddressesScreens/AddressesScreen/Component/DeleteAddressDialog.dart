import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> showDeleteAddressDialog(
    AddressModel address,
    BuildContext context,
    AddressesScreenController controller,
      Function() onSetState) async {
  Get.defaultDialog(
    title: "حذف عنوان ",
    content: Column(
      children: [
        Row(
          children: [
            Text("سيتم حذف العنوان "),
            Text(
              "${address.name}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        30.verticalSpace,
        Row(
          children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () => Get.back(), child: Text("الغاء العملية"))),
            20.horizontalSpace,
            Expanded(
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.red),
                  ),
                ),
                onPressed: () =>
                    controller.deleteAddress(address, context, onSetState),
                child: Text(
                  "حذف",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
