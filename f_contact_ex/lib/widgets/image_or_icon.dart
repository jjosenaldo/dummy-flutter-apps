import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageOrIcon extends StatelessWidget {
  const ImageOrIcon({
    this.imageSource,
    this.size = 50,
    this.icon = Icons.person,
  });

  final String? imageSource;
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return imageSource != null
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: MemoryImage(
                  File(imageSource!).readAsBytesSync(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: size,
            width: size,
          )
        : CircleAvatar(
            child: Icon(
              icon,
              size: size * 0.6,
            ),
            minRadius: size / 2,
            maxRadius: size / 2,
          );
  }
}
