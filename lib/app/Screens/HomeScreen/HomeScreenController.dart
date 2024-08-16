import 'dart:io';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:delevary/app/Services/LocalNotificationService.dart';
import 'package:delevary/app/Services/PermissionService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:helper/utility/base_client.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:logger/logger.dart';

// import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import '../../Services/CartService.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
// import 'package:open_file_safe_plus/open_file_safe_plus.dart';

class HomeScreenController extends GetxController
    with ApiHelperMixin, PaginationMixin<ProductModel> {
  RxDouble cureentDownload = RxDouble(0);
  RxList<CategoryModel> categories = RxList([]);
  RxList<SliderModel> sliders = RxList([]);
  RxBool isDownload = RxBool(false);
  final CartService cartService = CartService();
  final GlobalKey<CartIconKey> cartKey =
      Get.find<MainScaffoldScreenController>().cartKey;

  // Future getApp(BuildContext context) async {
  //   if (!isDownload.value) {
  //     await PermissionService.postStoragePermission();
  //     await PermissionService.postInstallPackagesPermission();
  //     cureentDownload.value = 0;
  //     isDownload.value = true;
  //     String? downloadsDirectoryPath = (await DownloadsPath.downloadsDirectory(
  //             dirType: DownloadDirectoryTypes.downloads))
  //         ?.path;
  //     Logger().w("downloadsDirectoryPath=>$downloadsDirectoryPath");
  //     String v = Get.find<MainController>()
  //         .setting
  //         .value!
  //         .currentVersion!
  //         .replaceFirst('.', "")
  //         .replaceFirst('.', "");
  //
  //     String appName = 'tasawoqe$v';
  //     String fullPath = "$downloadsDirectoryPath/$appName.apk";
  //
  //     if (await File(fullPath).exists()) {
  //       appName += 'new';
  //       fullPath = "$downloadsDirectoryPath/$appName.apk";
  //       if (await File(fullPath).exists()) {
  //         appName += 'new';
  //         fullPath = "$downloadsDirectoryPath/$appName.apk";
  //       }
  //     }
  //     await BaseClient.download(
  //         url: "${Get.find<MainController>().setting.value!.appUrl}",
  //         savePath: fullPath,
  //         onReceiveProgress: (int1, int2) {
  //           int val = (int1 * 100) ~/ int2;
  //           cureentDownload.value = val.toDouble();
  //           LocalNotificationService.showProgressNotification(
  //               title: "تحديث التطبيق",
  //               progress: val,
  //               desc: "يتم تحميل احدث نسخة من تطبيق تسوقي");
  //         },
  //         onError: (error) {
  //           Fluttertoast.showToast(msg: "خطأ في التحميل ");
  //           isDownload.value = false;
  //           LocalNotificationService.showProgressNotification(
  //               title: "تحديث التطبيق",
  //               progress: 100,
  //               desc: "حدث خطاء اثناء التحميل ${error.message}");
  //         },
  //         onSuccess: () async {
  //           Fluttertoast.showToast(msg: "تم التحميل ");
  //           isDownload.value = false;
  //           OpenFileSafePlus.open(
  //             fullPath,
  //           );
  //           LocalNotificationService.showProgressNotification(
  //               title: "تحديث التطبيق",
  //               progress: 100,
  //               desc: "تم تحميل احدث نسخة من تطبيق تسوقي");
  //           OpenFileSafePlus.open(fullPath);
  //         });
  //   }
  // }

  @override
  void onInit() {
    paginationUrl = ApiRoute.products;
    getFreshData();

    super.onInit();
  }

  Future getFreshData({bool refresh = false}) async {
    if (refresh) {
      // getSingleData(
      //   url: UrlModel(
      //     url: ApiRoute.settings,
      //     type: "settings",
      //     parameter: {"token": Get.find<MainController>().token.value},
      //   ),
      // );
      int count = Random().nextInt(10) + 1;
      String token =
          "${Get.find<MainController>().token.value}${generateRandomString(count)}";
      postData(
          url: ApiRoute.settings,
          data: {
            "_method": "GET",
            "token": token,
            "ct": count,
          },
          onSuccess: (re, er) {
            Get.find<MainController>().setting.value =
                SettingModel.fromJson(re.data['data']['setting']);
          },
          onError: (re, er) {});
    }
    getPaginationData(isRefresh: true);
    await getSingleDataWithSync(
      url: UrlModel(url: ApiRoute.home, type: "home"),
    );
    paginationUrl = ApiRoute.products;
  }

  loadMore() {
    getPaginationData(isRefresh: false);
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (json['status'] == "SUCCESS") {
      if (type == "home") {
        categories.value = [];
        for (var category in json['data']['categories']) {
          categories.add(CategoryModel.fromJson(category));
        }
        sliders.value = [];
        for (var slid in json['data']['sliders']) {
          sliders.add(SliderModel.fromJson(slid));
        }
      }
    } else {
      Fluttertoast.showToast(msg: json['data']?['message']);
    }
  }

  @override
  List<ProductModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['data']['products']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
