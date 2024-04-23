import 'package:afronex_shop_app/controller/other/textfield_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormContainer extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? inputType;
  final bool? isPasswordField;
  final bool? isReadOnly;
  final Icon? prefixIcon;
  final double width;
  final TextFieldController textfieldController = Get.find();
  FormContainer(
      {super.key,
      required this.width,
      this.controller,
      this.hintText,
      this.labelText,
      this.inputType,
      this.isPasswordField,
      this.isReadOnly,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.09,
      width: width,
      child: GetBuilder<TextFieldController>(builder: (_) {
        return TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: isPasswordField == true
              ? textfieldController.obscureText.value
              : false,
          readOnly: isReadOnly == true ? true : false,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              labelText: labelText,
              suffix: GestureDetector(
                onTap: () {
                  textfieldController.obscureToggler();
                },
                child: isPasswordField == true
                    ? (textfieldController.obscureText.value
                        ? const Icon(Icons.visibility_off, color: Colors.grey)
                        : Icon(Icons.visibility,
                            color: Theme.of(context).primaryColor))
                    : const Spacer(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )),
        );
      }),
    );
  }
}
