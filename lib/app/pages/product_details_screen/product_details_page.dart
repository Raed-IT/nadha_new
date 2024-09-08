import 'package:get/get.dart';
import 'package:nadha/app/pages/product_details_screen/product_details_binding.dart';
import 'package:nadha/app/pages/product_details_screen/product_details_screen.dart';
import 'package:nadha/app/route/routs.dart';

class ProductDetailsPage extends GetPage{
  ProductDetailsPage():super(
    name: AppRoutes.PRODUCT_DETAILS,
    page: ()=>ProductDetailsScreen(),
    binding: ProductDetailsBinding()
  );
}