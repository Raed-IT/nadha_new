import 'package:delevary/app/Route/Routs.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

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
    }
  }
}
