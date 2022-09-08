import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.textInputType = TextInputType.name,
    required this.labelText,
    required this.prefix,
    this.passwordTextFormField = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final String labelText;
  final Widget prefix;
  final bool passwordTextFormField;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
// TODO ortak bir yere alınmalı

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isPasswordTextFormField;
  late bool isShowPassword;

  @override
  void initState() {
    _isPasswordTextFormField = widget.passwordTextFormField;
    isShowPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: !isShowPassword,
      decoration: InputDecoration(
        fillColor: Colors.brown.withOpacity(0.6),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        labelText: widget.labelText,
        prefixIcon: widget.prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        suffixIcon: !_isPasswordTextFormField
            ? null
            : IconButton(
                onPressed: () {
                  isShowPassword = !isShowPassword;
                  setState(() {});
                },
                icon: Icon(isShowPassword ? Icons.remove_red_eye : Icons.visibility_off),
              ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
