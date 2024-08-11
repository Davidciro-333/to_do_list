import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String textTitle;
  final Color? color;

  const TextTitle(this.textTitle, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return  Text(
      textTitle,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color
      ),
    );
  }
}
