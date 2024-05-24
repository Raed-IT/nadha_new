import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

class PhoneNumberComponent extends StatelessWidget {
  final void Function(PhoneNumber)? onChange;
final TextEditingController textFieldController;
  const PhoneNumberComponent({super.key, this.onChange, required this.textFieldController});

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textFieldController:textFieldController,
      selectorConfig:
      SelectorConfig(selectorType: PhoneInputSelectorType.DROPDOWN),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (d) {
        if (d!.isEmpty) {
          return "رقم الهاتف مطلوب";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      onInputChanged: onChange,

    );
  }
}
