import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenBinding.dart';
import 'package:get/get.dart';

import 'ProfileScreen.dart';

class ProfilePage extends GetPage {
  ProfilePage()
      : super(
          name: AppRoutes.profileScreen,
          page: () => ProfileScreen(),
          binding: ProfileScreenBinding(),
        );
}
