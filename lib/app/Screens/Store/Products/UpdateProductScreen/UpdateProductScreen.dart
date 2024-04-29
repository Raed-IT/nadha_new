import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/DropDwon.dart';
import 'package:delevary/app/Components/ImagePickerComponent.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Screens/Store/Products/AddProductScreen/AddProductScreenController.dart';
import 'package:delevary/app/Screens/Store/Products/UpdateProductScreen/UpdateProductScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../../Components/DrawerComponents/DrawerComponent.dart';
import '../Components/OptionsAddProductComponents.dart';
import 'package:slugify/slugify.dart';

class UpdateProductScreen extends GetView<UpdateProductScreenController> {
  final ScrollController scrollController = ScrollController();

  UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ).animate().blur(
                    delay: const Duration(milliseconds: 500),
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 2),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    title: "تعديل منتج",
                    openDrawer: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: BlurryContainer(
                        blur: 7,
                        child: Form(
                          key: controller.formKey,
                          child: ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              20.verticalSpace,
                              ImagePickerComponent(
                                onPicked: (files) {
                                  if (files.isNotEmpty) {
                                    controller.productImage = files.first;
                                  } else {
                                    controller.productImage = null;
                                  }
                                },
                                image: controller.product.image,
                                title: Text(
                                  'صورة المنتج',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ),
                              20.verticalSpace,
                              OptionsAddProductComponent(
                                title: 'وحد القياس',
                                onChange: (String val) {
                                  controller.unitType = val;
                                },
                                initVal: controller.unitType,
                                values: const {
                                  "piece": "قطعة",
                                  "kg": "كمية او سعر",
                                },
                              ),
                              TextFieldComponent(
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return "اسم المنتج مطلوب";
                                    } else if (name.length < 3) {
                                      return "اقل عدد لاسم المنتج 3 احرف";
                                    }
                                    return null;
                                  },
                                  label: "اسم المنتج",
                                  controller: controller.nameController,
                                  hint: "اسم المنتج"),
                              TextFieldComponent(
                                  validator: (slug) {
                                    if (slug!.isEmpty) {
                                      return "اسم الفريد للمنتج مطلوب";
                                    } else if (slug.length < 3) {
                                      return "اقل عدد الفريد للمنتج 3 احرف";
                                    }
                                    return null;
                                  },
                                  label: " اسم المنتج الفريد ",
                                  controller: controller.slugController,
                                  hint: "اسم المنتج الفريد"),
                              TextFieldComponent(
                                  validator: (info) {
                                    if (info!.isEmpty) {
                                      return "وصف المنتج مطلوب";
                                    } else if (info.length < 10) {
                                      return "اقل عدد لوصف المنتج 10 احرف";
                                    }
                                    return null;
                                  },
                                  label: " وصف المنتج",
                                  isMultiple: true,
                                  controller: controller.infoController,
                                  hint: "وصف المنتج"),
                              TextFieldComponent(
                                label: "اقل كمية",
                                validator: (minQty) {
                                  if (minQty!.isEmpty) {
                                    return "املاء حقل اقل كمية للطلب";
                                  } else if (double.tryParse(minQty) == null) {
                                    return "الرجاء ادخال رقم صجيج";
                                  }
                                  return null;
                                },
                                controller: controller.minQtyController,
                                hint: "اقل كمية",
                                keyboardType: TextInputType.number,
                              ),
                              20.verticalSpace,
                              const Text(
                                "اختر القسم",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              10.verticalSpace,
                              DropDownComponent<CategoryModel>(
                                  initVal: controller.selectedCategory,
                                  items: Get.find<MainController>()
                                      .storeCategories,
                                  onSelected: (category) {
                                    controller.selectedCategory = category;
                                  },
                                  hintText: "اختر القسم"),
                              Divider(
                                color: Theme.of(context).colorScheme.primary,
                                thickness: 1.sp,
                                height: 50.h,
                              ),
                              OptionsAddProductComponent(
                                title: 'العملة الإفتراضية للمنتج',
                                onChange: (String val) {
                                  controller.currencyType = val;
                                },
                                initVal: controller.currencyType,
                                values: const {
                                  "try": "تركي",
                                  "USD": "دولار",
                                },
                              ),
                              TextFieldComponent(
                                validator: (price) {
                                  if (price!.isEmpty) {
                                    return "املاء حقل السعر للمنتج";
                                  } else if (double.tryParse(price) == null) {
                                    return "الرجاء ادخال رقم صجيج";
                                  }
                                  return null;
                                },
                                label: "سعر المنتج",
                                controller: controller.priceController,
                                hint: "سعر المنتج",
                                keyboardType: TextInputType.number,
                              ),
                              10.verticalSpace,
                              Obx(
                                () => Row(
                                  children: [
                                    Switch(
                                        value: controller.isDiscount.value,
                                        onChanged: (va) {
                                          controller.isDiscount.value = va;
                                        }),
                                    Text("هل يوجد خصم"),
                                  ],
                                ),
                              ),
                              Obx(
                                () => (controller.isDiscount.value)
                                    ? TextFieldComponent(
                                        validator: (discount) {
                                          if (controller.isDiscount.value &&
                                              discount!.isEmpty) {
                                            return "الرجاء ملئ حقل الخصم";
                                          } else if (double.tryParse(
                                                  discount!) ==
                                              null) {
                                            return "الرجاء ادخال رقم صجيج";
                                          } else if (double.parse(discount) >=
                                              double.parse(controller
                                                  .priceController.text)) {
                                            return "يجب ان يكون الخصم اقل من السعر";
                                          }
                                          return null;
                                        },
                                        label: "السعر بعد الخصم",
                                        controller:
                                            controller.discountController,
                                        hint: "السعر بعد الخصم",
                                        keyboardType: TextInputType.number,
                                      )
                                    : Container(),
                              ),
                              10.verticalSpace,
                              SizedBox(
                                height: 50.h,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () =>
                                      controller.updateProduct(context),
                                  child: Text(
                                    "تعديل المنتج",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
