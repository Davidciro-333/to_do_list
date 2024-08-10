import 'package:flutter/material.dart';

class ConvexTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Color activeColor;
  final bool active;
  final VoidCallback onTap;

  const ConvexTab({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.activeColor,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = active ? activeColor : this.color;
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: color);
    final iconWidget = Icon(icon, color: color);
    final titleWidget = Text(title, style: textStyle);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          iconWidget,
          titleWidget,
        ],
      ),
    );
  }
}