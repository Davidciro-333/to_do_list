import 'package:flutter/material.dart';
import 'package:to_do_list/app/view/home/inherited_widgets.dart';
//import 'package:to_do_list/app/view/counter/counter_page.dart';
import 'package:to_do_list/app/view/splash/splash_page.dart';

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  /// Builds the widget tree for the application.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    // Define the primary color for the application.
    const primaryColor = Color(0xFF40B7AD);
    // Define the text color for the application.
    const textColor = Color(0xFF4A4A4A);
    // Define the background color for the application.
    const backgroundColor = Color(0xFFF5F5F5);

    return SpecialColor(
      color: Colors.deepPurple,
      child: MaterialApp(
        // The title of the application.
        title: 'Flutter Demo',
        // The theme of the application.
        theme: ThemeData(
          // Define the color scheme based on the primary color.
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          // Use Material 3 design.
          useMaterial3: true,
          // Set the scaffold background color.
          scaffoldBackgroundColor: backgroundColor,
          // Apply text theme with custom font and colors.
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: textColor,
              displayColor: textColor
          ),
          // Define the theme for elevated buttons.
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ),
          // Define the theme for text buttons.
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 4),
              ),
            )
          )
        ),
        // Disable the debug banner.
        debugShowCheckedModeBanner: false,
        // Set the home page of the application.
        home: const SplashPage(),
      ),
    );
  }
}