import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:nadha/app/pages/components/drawer_component.dart';
import 'package:nadha/app/pages/components/pagination/load_more_component.dart';
import 'package:nadha/app/them/app_colors.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/data/local_storage_controller.dart';
import 'app/pages/components/pagination/no_data_component.dart';
import 'app/route/get_pages.dart';
import 'app/route/routs.dart';
import 'app/route_observe.dart';
import 'app/them/them_data.dart';
//flutter build apk --release  --target-platform android-arm
// cancel or finish  not show
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(AppRoutes.APP_NAME);
  HelperMadaFlutter.initial(appName: AppRoutes.APP_NAME);
  ConstantHelperMadaFlutter.allowPrintResponse = true;
  ConstantHelperMadaFlutter.allowPrint = true;
  ConstantHelperMadaFlutter.normalApiVal = "Success";
  ConstantHelperMadaFlutter.scaffoldColor = AppColors.scaffold;

  /// widgets
  ConstantHelperMadaFlutter.endDrawerWidget = DrawerComponent();
  ConstantHelperMadaFlutter.noDataWidget = const NoDataMorComponent();
  ConstantHelperMadaFlutter.loadMoreWidget = const LoadModerComponent();

  /// end widgets
  ConstantHelperMadaFlutter.scrollPhysics =
      const AlwaysScrollableScrollPhysics();
  Get.put(MainController(), permanent: true);
  // await OneSignal.shared.setAppId("20fc2214-d92b-4e6f-9747-6683768aa611");
  // await StorageController.removeKey(key: "token");
  Get.find<MainController>().token.value =
      await StorageController.getData(key: "token");
  var user = await StorageController.getData(key: "user");
  if (user != null) {
    Get.find<MainController>().user.value = UserModel.fromJson(user);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
    );
    // Helper.setCartItemToLocaleStorage();
    return ScreenUtilInit(
      designSize: const Size(382.65, 824.57),
      builder: (BuildContext context, Widget? child) {
        ConstantHelperMadaFlutter.toastFontSize = 15.sp;
        ConstantHelperMadaFlutter.loadMorAtHeight = 500.h;
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 2000)
          ..indicatorType = EasyLoadingIndicatorType.wave //fadingCircle
          ..loadingStyle = EasyLoadingStyle.light
          ..indicatorSize = 45.0.h
          ..radius = 10.0
          ..maskColor = Colors.blue.withOpacity(0.5)
          ..userInteractions = true
          ..dismissOnTap = false;
        return GetMaterialApp(
          title: "عـ الندهة",
          builder: EasyLoading.init(),
          initialRoute: AppRoutes.SPLASH_SCREEN,
          getPages: [
            ...GetPagesProvider.getPages,
          ],
          theme: ThemeAppData.themeData,
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          navigatorObservers: [MainRouteObserver()],
        );
      },
    );
  }
}
