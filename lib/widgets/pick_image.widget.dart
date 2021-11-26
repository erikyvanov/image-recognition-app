import 'dart:io';

import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  const PickImage(
      {Key? key,
      required this.image,
      required this.onTap,
      required this.backgroundColor})
      : super(key: key);

  final File? image;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: image != null
            ? Image.file(
                image!,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fitHeight,
              )
            : Container(
                decoration: BoxDecoration(color: backgroundColor),
                width: 200,
                height: 200,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 35,
                ),
              ),
      ),
    );
  }
}
