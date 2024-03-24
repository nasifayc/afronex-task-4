import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? inputType;
  final bool? isPasswordField;
  final bool? isReadOnly;

  const FormContainer(
      {super.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.inputType,
      this.isPasswordField,
      this.isReadOnly});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        readOnly: widget.isReadOnly == true ? true : false,
        decoration: InputDecoration(
            labelText: widget.labelText,
            suffix: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? (_obscureText == true
                      ? const Icon(Icons.visibility_off, color: Colors.grey)
                      : Icon(Icons.visibility, color: Theme.of(context).primaryColor))
                  : const Spacer(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            )),
      ),
    );
  }
}
