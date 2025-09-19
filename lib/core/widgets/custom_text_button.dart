import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,required this.text,required this.onPress,this.textAlign=TextAlign.center});
  
  final String text;
  final VoidCallback onPress;
  final TextAlign textAlign;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        text,
        textAlign: textAlign,

        style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color:ColorsManager.blue,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue
      ),),
    );
  }
}
