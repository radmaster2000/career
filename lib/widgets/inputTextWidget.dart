import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:career/utils/app_colors.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool isDescription; // Flag to indicate if this is a description field
  final int? minLines; // Minimum lines for description field
  final int? maxLines; // Maximum lines for description field

  const InputTextWidget({
    required this.labelText,
    this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.isDescription = false,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 36, vertical: height / 96),
              child: Text(labelText,
                  style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                      fontSize: 12, color: AppColors.primary)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 36),
              child: TextFormField(
                style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                  fontSize: 14,
                ),
                controller: controller,
                obscureText: obscureText,
                keyboardType: isDescription ? TextInputType.multiline : keyboardType,
                maxLines: isDescription ? (maxLines ?? 5) : 1,
                minLines: isDescription ? (minLines ?? 3) : null,
                cursorColor: AppColors.textgray,
                textInputAction: isDescription ? TextInputAction.newline : TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: icon != null ? Icon(icon) : null,
                  hintText: labelText,
                  hintStyle: TextStyle(fontFamily: 'LexendMedium').copyWith(
                      fontSize: 14, color: AppColors.textgray),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: isDescription ? height / 48 : 0,
                  ),
                ),
              ),
            ),
            SizedBox(height: isDescription ? 0 : height / 96),
          ],
        ),
      ),
    );
  }
}
