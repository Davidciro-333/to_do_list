import 'package:flutter/material.dart';

import 'app_bar.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Image.asset('assets/images/Real-Madrid.png')
           ]
        ),
      ),
    );
  }
}