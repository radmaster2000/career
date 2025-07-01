

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.avatarURL,
    this.maxRadius = 12,
    this.expanded = true,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Uint8List? avatarURL;
  final double? maxRadius;
  final bool expanded;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0, right: 1.0),
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Image.memory(
              avatarURL!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            // CachedNetworkImage(
            //   imageUrl: avatarURL.toString(),
            //   errorWidget: (context, url, error) => CircleAvatar(
            //     maxRadius: maxRadius,
            //     child: const Icon(
            //       Icons.person,
            //       size: 17,
            //       color: AppColors.disabled,
            //     ),
            //   ),
            //   imageBuilder: (context, imageProvider) => CircleAvatar(
            //     maxRadius: maxRadius,
            //     backgroundImage: imageProvider,
            //   ),
            // ),
            if (title != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title!, style: titleStyle ?? TextStyle(fontSize: 15, height: 1.2)),
                      if (subtitle != null) Text(subtitle!, style: subtitleStyle ?? TextStyle(fontSize: 12, height: 1.2)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
