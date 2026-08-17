import 'package:flutter/material.dart';

import '../config/app_config.dart';

class InkViewfinder extends StatelessWidget {
  const InkViewfinder({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: 220,
      height: 220,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: colors.tertiary, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Icon(
            Icons.camera_alt_outlined,
            size: AppConfig.heroIconSize,
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
