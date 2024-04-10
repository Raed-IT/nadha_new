import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AddressesScreens/Components/MarkerComponent.dart';
import 'package:delevary/app/Services/LocationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import '../../../Services/UI/OverlayLoaderService.dart';
import '../../../Services/UI/ToastService.dart';

class AddAddressScreenController extends GetxController with ApiHelperMixin {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressInfoController = TextEditingController();
  late GoogleMapController mapController;
  RxList<Marker> marker = RxList([]);
  PanelController panelController = PanelController();

  Future<void> addAddress(BuildContext context) async {
    if (marker.isEmpty) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار الموقع في الخريطة');
      return;
    }
    if (formKey.currentState!.validate()) {
      OverlayLoaderService.show(context);
      await postData(
          url: ApiRoute.addresses,
          data: {
            "user_id": Get.find<MainController>().user.value?.id,
            "name": addressNameController.text,
            "info": addressInfoController.text,
            "lat": marker.first.position.latitude,
            "long": marker.first.position.longitude,
          },
          onSuccess: (res, ty) {
            AddressModel addedAddress =
                AddressModel.fromJson(res.data['data']['address']);
            ToastService.showSuccessToast(
                context: context, title: 'تم اضافة العنوان');
            Get.find<MainController>().user.value!.addresses!.add(addedAddress);
            Get.find<MainController>().selectedAddress.value = addedAddress;
            Get.offNamed(AppRoutes.addresses);
          },
          onError: (ex, ty) {
            ToastService.showSuccessToast(
                context: context, title: 'خطاء عند إضافة العنوان');
          });
      Loader.hide();
    }
  }

  void addMarker(LatLng latLng, {bool moveCamera = false}) async {
    marker.value = [];
    Marker currentMarker = Marker(
      markerId: MarkerId("user"),
      position: latLng,
      icon: await MarkerComponent().toBitmapDescriptor(
          logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
    );
    marker.add(currentMarker);
    if (moveCamera) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 14,
          ),
        ),
      );
    }
    panelController.open();
  }

  Future<void> myLocation(BuildContext context) async {
    LocationService locationService = LocationService();
    LocationData? location = await locationService.getLocation();
    if (location != null) {
      addMarker(LatLng(location.latitude!, location.longitude!),
          moveCamera: true);
    } else {
      ToastService.showErrorToast(
          context: context, title: "فشل في اختيار الموقع");
    }
  }
}
