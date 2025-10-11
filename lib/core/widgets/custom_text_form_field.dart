import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.secureText=false,
    this.validator,
    this.controller,
    this.lines=1
  });

  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool secureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int lines;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      maxLines: lines,
      controller: controller,
      validator: validator,
      obscureText: secureText,
      keyboardType: keyboardType,
      style: TextStyle(color: Theme.of(context).canvasColor),
      decoration: InputDecoration(
        labelText:labelText,
        prefixIcon:prefixIcon==null? null: Icon(prefixIcon),
        suffixIcon:suffixIcon,



      ),
    );
  }
}
