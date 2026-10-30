import 'dart:io';

import 'package:flutter/material.dart';

class EmployeeAvatar extends StatelessWidget {
  EmployeeAvatar({super.key, required this.path, required this.size});

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Icon(Icons.person, size: size),
      ),
    );
  }
}
