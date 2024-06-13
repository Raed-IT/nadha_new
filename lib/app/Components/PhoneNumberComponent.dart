// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:logger/logger.dart';
//
// class PhoneNumberComponent extends StatelessWidget {
//   final void Function(PhoneNumber)? onChange;
//   final TextEditingController? controller;
//   final PhoneNumber? initialValuel;
//
//   const PhoneNumberComponent({
//     super.key,
//     this.onChange,
//     this.controller,
//     this.initialValuel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 20.h),
//       child: InternationalPhoneNumberInput(
//         locale: "ar",
//         initialValue: initialValuel,
//         selectorConfig: const SelectorConfig(
//             selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (d) {
//           if (d!.isEmpty) {
//             return "رقم الهاتف مطلوب";
//           }
//           return null;
//         },
//         inputDecoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide:
//                 BorderSide(color: Theme.of(context).colorScheme.onBackground),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black12),
//             borderRadius: BorderRadius.circular(15.sp),
//           ),
//           contentPadding:
//               EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
//           filled: true,
//           fillColor: Theme.of(context).colorScheme.onPrimary,
//         ),
//         keyboardType: TextInputType.number,
//         onInputChanged: onChange,
//       ),
//     );
//   }
// }
