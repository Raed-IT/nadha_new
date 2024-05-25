import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinksService {
  DeepLinksService._();

  static init() async {
    String? initialLink = await getInitialLink();
    _processLink(initialLink);
  }

  static _processLink(String? link) {
    if (link == null) {
      return;
    }
    if (link.contains("stores")) {
      var data = link.split('/');
      var id = data.last;
      Get.toNamed(AppRoutes.showStore, arguments: {"store_id": id});
    } else if (link.contains("products")) {
      var data = link.split('/');
      var id = data.last;
      Get.toNamed(AppRoutes.showProduct, arguments: {"product_slug": id});
      Get.put(ShowProductScreenController(), tag: "show_product");
    } else {
      Get.toNamed(AppRoutes.lunchUrl,
          arguments: {'url': "${ApiRoute.redirectDomin}?url=$link"});
    }
  }
}
