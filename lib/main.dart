import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/route/GetPages.dart';
import 'package:delevary/app/thems/DarckThem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helper/data/models/dio_config_model.dart';
import 'package:helper/helper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'app/Data/MainController.dart';
import 'app/Services/LocalNotificationService.dart';
import 'app/route/routs.dart';
import 'app/thems/LightThem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDateFormatting('ar', null);

  await GetStorage.init(AppRoutes.appName);
  Helper.initial(
      appName: "tasawoqe", local: "ar", apiConfig: ApiConfig.activeAll());

  Get.put(MainController(), permanent: true);
  await LocaleStorageService.getUserData();
  String? onSignalId = await LocaleStorageService.getOnSignalId();
  if (onSignalId != null) {
    await OneSignal.shared.setAppId(onSignalId);
  } else {
    // await OneSignal.shared.setAppId("0c4508b7-d21e-4c75-8dad-e4e6d543981a");
    await OneSignal.shared.setAppId("15e9ed43-12dc-4bb3-abb4-2326cf4711fd");
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Get.find<MainController>().packageInfo = packageInfo;
  LocalNotificationService.initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
    );
    return ScreenUtilInit(
      // designSize: const Size(382.65, 824.57),
      designSize: const Size(360, 800),
      builder: (BuildContext context, Widget? child) {
        return Obx(
          () => GetMaterialApp(
            builder: (context, widget) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaleFactor: 1,
                ),
                child: widget!,
              );
            },
            theme: LightThemeData.them(),
            darkTheme: DarkThemeData.them(),
            title: "تسوقي",
            initialRoute: AppRoutes.splashScreen,
            getPages: [
              ...GetPagesProvider.getPages,
            ],
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            fallbackLocale: const Locale('ar'),
            themeMode: Get.find<MainController>().themeMode.value,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ThemeMode themeMode = Get.find<MainController>().themeMode.value;
          if (themeMode == ThemeMode.dark) {
            Get.find<MainController>().themeMode.value = ThemeMode.light;
          } else {
            Get.find<MainController>().themeMode.value = ThemeMode.dark;
          }
        },
      ),
      body: const Column(
        children: [SizedBox(height: 100, width: 300, child: Card())],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}
