import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? initials;
  final double radius;
  final Color? color;

  const AvatarWidget({
    super.key,
    this.initials,
    this.radius = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color ?? Theme.of(context).primaryColor,
      child: initials != null
          ? Text(
              initials!,
              style: TextStyle(
                color: Colors.white,
                fontSize: radius * 0.8,
              ),
            )
          : const Icon(Icons.person, color: Colors.white),
    );
  }
}