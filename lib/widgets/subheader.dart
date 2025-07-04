


import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

enum ActionIconPosition { start, end }

class SubHeader extends StatelessWidget {
  const SubHeader({
    required this.title,
    this.actionLabel,
    this.actionIcon,
    this.actionIconSize = 14.5,
    this.actionIconPosition = ActionIconPosition.end,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? actionLabel;
  final IconData? actionIcon;
  final double actionIconSize;
  final ActionIconPosition actionIconPosition;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      actionIcon ?? Icons.arrow_forward_ios,
      size: actionIconSize,
      color: AppColors.disabled,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 19, height: 1.2)),
            if (onPressed != null || onPressed != null || onPressed != null)
              InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      if (actionIconPosition == ActionIconPosition.start) icon,
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          actionLabel ?? '',
                          style: TextStyle(fontSize: 14, height: 1.2),
                        ),
                      ),
                      //if (actionIconPosition == ActionIconPosition.end) icon,
                    ],
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
