import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static void showSuccessToast(
      {required BuildContext context,
      required String title,
      String? description}) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      icon: const Icon(FontAwesomeIcons.check),
      description: description != null ? Text(description) : null,
      progressBarTheme: ProgressIndicatorThemeData(
          color: Theme.of(context).colorScheme.primary,
          linearMinHeight: 3.sp,
          linearTrackColor: Theme.of(context).colorScheme.surface),
      title: Text(title),
      showProgressBar: false,
    );
  }

  static void showErrorToast(
      {required BuildContext context,
      required String title,
      String? description}) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      icon: const Icon(FontAwesomeIcons.circleExclamation),
      description: description != null ? Text(description) : null,
      progressBarTheme: ProgressIndicatorThemeData(
          color: Theme.of(context).colorScheme.error,
          linearMinHeight: 3.sp,
          linearTrackColor: Theme.of(context).colorScheme.onError),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
