import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

Widget countBadge(int count) {
  return Container(
    padding: const EdgeInsets.all(4),
    constraints: const BoxConstraints(
      minWidth: 17,
      minHeight: 17,
    ),
    decoration: const BoxDecoration(
      color: azaleaPink,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}