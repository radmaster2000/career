import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DotContainer extends StatelessWidget {
  const DotContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        width: 3,
        height: 3,
        decoration: const BoxDecoration(
          color: AppColors.disabled,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}