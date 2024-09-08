import 'package:get/get.dart';
import 'package:nadha/app/pages/profile_screen/profile_binding.dart';
import 'package:nadha/app/pages/profile_screen/profile_screen.dart';
import 'package:nadha/app/route/routs.dart';

class ProfilePage extends GetPage {
  ProfilePage()
      : super(
            name: AppRoutes.PROFILE_SCREEN,
            binding: ProfileScreenBinding(),
            page: () => ProfileScreen());
}
