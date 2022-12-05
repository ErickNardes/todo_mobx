import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.radius,
      required this.iconData,
      required this.onTap,
      required this.color});

  final double radius;
  final IconData iconData;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Icon(iconData),
          onTap: onTap,
        ),
      ),
    );
    ;
  }
}
