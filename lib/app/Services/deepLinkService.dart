import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinksService {
  DeepLinksService._();

  static init() async {
    String? initialLink = await getInitialLink();
    _processLink(initialLink);
  }

  static _processLink(String? link) {
    if (link != null && link.contains("stores")) {
      var data = link.split('/');
      var id = data.last;
      Get.toNamed(AppRoutes.showStore, arguments: {"store_id": id});
    } else {
      if (link != null) {
        Get.defaultDialog(
          title: "الانتقال الى الرابط",
          content: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: MaterialButton(
                    // color: Theme.of(context).colorScheme.primary,
                      child:const Center(child: const Text('فتح الرابط')),
                      onPressed: () async {
                        // bool st =false;
                        // = await launchUrl(Uri.parse(link),
                        //     mode: LaunchMode.externalApplication);
                        // Fluttertoast.showToast(msg: "$st ");
                        // st = await launchUrl(Uri.parse(link),
                        //     mode: LaunchMode.externalNonBrowserApplication);
                        // Fluttertoast.showToast(msg: "$st ");
                        // st = await launchUrl(Uri.parse(link),
                        //     mode: LaunchMode.inAppBrowserView);
                        // Fluttertoast.showToast(msg: "$st ");
                         launchUrl(Uri.parse(link),
                            mode: LaunchMode.inAppWebView);
                        // Fluttertoast.showToast(msg: "$st ");
                      }),
                ),
              )
            ],
          ),
        );
      }
    }
  }
}
