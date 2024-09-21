import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginScreenBinding.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:get/get.dart';

class LoginPage extends GetPage{
  LoginPage():super(
    page: ()=>LoginScreen(),
    name: AppRoutes.loginScreen,
    binding: LoginScreenBinding(),
  );
}