import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreen.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreenBinidng.dart';
import 'package:get/get.dart';

class SearchPage extends GetPage {
  SearchPage()
      : super(
          name: AppRoutes.searchScreen,
          page: () => SearchScreen(),
          binding: SearchScreenBinding(),
        );
}
