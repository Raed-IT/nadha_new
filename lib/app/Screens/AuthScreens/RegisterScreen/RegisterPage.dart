import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreen.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenBinding.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:get/get.dart';

class RegisterPage extends GetPage {
  RegisterPage()
      : super(
            name: AppRoutes.registerScreen,
            page: () => RegisterScreen(),
            binding: RegisterScreenBinding());
}
