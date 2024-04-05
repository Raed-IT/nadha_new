import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreenController.dart';
import 'package:delevary/app/Screens/AddressesScreens/Components/showAddressBottomSheet.dart';
import 'package:flutter/material.dart';

import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenController.dart';
import 'package:delevary/app/Screens/AddressesScreens/Components/AddressesEmptyComponent.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../Components/DrawerComponents/DrawerComponent.dart';
import 'Component/DeleteAddressDialog.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  AddressesScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.sp),
        ),
        onPressed: () => Get.toNamed(AppRoutes.addAddress),
        heroTag: null,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 18.sp,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ).animate().slideY(begin: 1, duration: 700.ms),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ).animate().blur(
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 2),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    title: "العناوين الخاصة بي ",
                    openDrawer: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: (Get.find<MainController>()
                            .user
                            .value!
                            .addresses!
                            .isNotEmpty)
                        ? ListView(
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            children: Get.find<MainController>()
                                .user
                                .value!
                                .addresses!
                                .map((address) =>
                                    buildCardAddress(address, context, () {
                                      setState(() {});
                                    }))
                                .toList())
                        : AddressesEmptyComponent(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardAddress(
      AddressModel address, BuildContext context, Function() onSetState) {
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${address.name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${address.info}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => showAddressBottomSheet(address: address),
                    icon: const Icon(FontAwesomeIcons.mapMarker),
                  ),
                  IconButton(
                    onPressed: () => showDeleteAddressDialog(
                        address, context, controller, onSetState),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
