import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';

class OverlayLoaderService {
  static show(BuildContext context) {
    Loader.show(
      context,
      themeData: Theme.of(context),
      overlayColor: Colors.black45,
      progressIndicator: const LoaderComponent(),
    );
  }

  static hide() {
    Loader.hide();
  }
}

class LoaderComponent extends StatefulWidget {
  const LoaderComponent({super.key});

  @override
  State<LoaderComponent> createState() => _LoaderComponentState();
}

class _LoaderComponentState extends State<LoaderComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(-300.w, 0),
          child: AnimatedOpacity(
            opacity: controller.value,
            duration: 500.ms,
            child: Transform.translate(
              // scale: controller.value,
              offset: Offset(controller.value * 500, controller.value),
              child: child,
            ),
          ),
        );
      },
      child: Lottie.asset("assets/json/delevary_motor.json", width: 150.w),
    );
  }
}
