import 'package:get/get.dart';
import 'package:nadha/app/pages/auth_screen/auth_binding.dart';
import 'package:nadha/app/route/routs.dart';

import 'auth_screen.dart';

class AuthPage extends GetPage {
  AuthPage()
      : super(
            name: AppRoutes.AUTH_SCREEN,
            page: () => AuthScreen(),
            binding: AuthScreenBinding());
}
