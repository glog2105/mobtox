import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final bool isOnline;
  final double size;

  const StatusIndicator({
    super.key,
    required this.isOnline,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 2,
        ),
      ),
    );
  }
}