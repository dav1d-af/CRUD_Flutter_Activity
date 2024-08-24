import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final InputDecoration decoration;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration.copyWith(
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
