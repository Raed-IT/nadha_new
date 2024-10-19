import 'package:delevary/app/Components/v2/address_list_component/components/delete_dialog.dart';
import 'package:delevary/app/Components/v2/address_list_component/controller.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddressListComponent extends GetView<AddressListController> {
  final String? label;

  const AddressListComponent({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      label!,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await Get.toNamed(AppRoutes.addAddress);
                      },
                      icon: Icon(
                        FontAwesomeIcons.squarePlus,
                        color: AppColors.highLightColor,
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        Obx(
          () => ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.addresses.value.length,
            itemBuilder: (context, index) {
              return buildCard(controller.addresses.value[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCard(AddressModel address, BuildContext context) {
    MainController mainController = Get.find();
    return Obx(
      () => GestureDetector(
        onTap: () => mainController.selectedAddress.value = address,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              border: mainController.selectedAddress.value?.id == address.id
                  ? Border.all(color: AppColors.highLightColor)
                  : null),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: 100.h,
          width: Get.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            margin: EdgeInsets.zero,
            elevation: 5,
            shadowColor: Colors.black12,
            child: Padding(
              padding: EdgeInsets.all(18.sp),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          value: mainController.selectedAddress.value?.id,
                          groupValue: address.id,
                          onChanged: (da) {
                            mainController.selectedAddress.value = address;
                          },
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${address.name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () => deleteAddressDialog(
                                context: context,
                                address: address,
                                onDelete: (deletedAddress) =>
                                    controller.deleteAddress(
                                  address,
                                  context,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  FontAwesomeIcons.trashCan,
                                  size: 15.sp,
                                  color: AppColors.highLightColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Expanded(
                          child: Text(
                            "${address.info}  ",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.highLightColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
