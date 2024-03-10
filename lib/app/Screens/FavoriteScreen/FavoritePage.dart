import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/FavoriteScreen/FavoriteScreen.dart';
import 'package:delevary/app/Screens/FavoriteScreen/FavoriteScreenBinding.dart';
import 'package:get/get.dart';

class FavoritePage extends GetPage {
  FavoritePage()
      : super(
          name: AppRoutes.favorites,
          page: () => FavoriteScreen(),
          binding: FavoriteScreenBinding(),
        );
}
