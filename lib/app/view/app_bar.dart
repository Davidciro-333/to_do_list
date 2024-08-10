import 'package:flutter/material.dart';

class AppBarCustom extends PreferredSize {
  AppBarCustom({super.key, required Widget title}) : super(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      shape:  const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      shadowColor: Colors.black, // Set shadow color
      elevation: 5,
      surfaceTintColor: Colors.transparent,// Set elevation to 1

      //surfaceTintColor: Colors.transparent, // Set the surface color of the AppBar
      backgroundColor: Colors.red, // Set the background color of the AppBar
      //iconTheme: const IconThemeData(color: Colors.white), // Set icon color
      title: title,
      //backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      // maybe other AppBar properties
    ),
  );
}
