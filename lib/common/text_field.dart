import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    this.readOnly = false,
    this.hintText,
    this.labelText,
    this.onTap,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.maxlines = 1,
    this.suffixIcon,
  }) : super(key: key);
  final TextEditingController controller;
  final bool readOnly;
  final String? hintText;
  final String? labelText;
  final VoidCallback? onTap;
  final int? maxlines;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: textInputType,
      maxLines: maxlines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.blue)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.red)),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
