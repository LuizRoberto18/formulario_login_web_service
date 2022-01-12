import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  TextInputType? KeyboardType;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  FocusNode? nextFocus;

  FormText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.KeyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller!,
      obscureText: password,
      validator: validator,
      keyboardType: KeyboardType,
      keyboardAppearance: Brightness.dark,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String texto) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
