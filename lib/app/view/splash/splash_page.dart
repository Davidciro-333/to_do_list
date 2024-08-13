import 'package:flutter/material.dart';
import 'package:to_do_list/app/view/components/title.dart';
import 'package:to_do_list/app/view/home/inherited_widgets.dart';
//import 'package:to_do_list/app/view/home/state_dif.dart';
import 'package:to_do_list/app/view/task_list/task_list_page.dart';
//import 'package:to_do_list/app/view/task_list/task_list_page_example.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/shape.dart';

/// A stateless widget that represents the splash page of the application.
class SplashPage extends StatelessWidget {
  /// Creates a [SplashPage] widget.
  const SplashPage({super.key});

  /// Builds the widget tree for the splash page.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
return Scaffold(
  // A widget that provides a safe area for the content.
  body: SafeArea(
    child: Column(
      children: [
        // A row containing a custom shape widget.
        const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Shape()]),
        // Padding around the onboarding image.
        Padding(
          padding: const EdgeInsets.only(top: 72, bottom: 100),
          child: Image.asset(
            'assets/images/onboarding-image.png',
          ),
        ),
        // A custom title widget for the task list.
        const TextTitle('Task list'),
        // Padding around the description text.
        const Padding(
          padding: EdgeInsets.only(top: 21, left: 32, right: 32),
          child: Text(
            'The best way to not forget anything is to write it down. Save your tasks and gradually complete them to increase your productivity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        // A button to navigate to the StateDif page.
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
                  return const TaskListPage();
                }));
          },
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          child: const Text('Get started'),
        ),

        /// A text widget that displays the color provided by the inherited widget.
        Text('Inherited widget', style: TextStyle(color: SpecialColor.of(context).color)),

        // A spacer to push the following row to the bottom.
        const Spacer(),
        // A row containing buttons for terms of service and privacy policy.
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: _termsUrl, child: Text('Terms of service')),
            Text('and'),
            TextButton(onPressed: _privacyUrl, child: Text('privacy policy')),
          ],
        ),
      ],
    ),
  ),
);
  }
}

/// A list of URLs for terms of service and privacy policy.
final List<Uri> _url = [
  Uri.parse('https://docs.flutter.dev/tos'),
  Uri.parse('https://policies.google.com/privacy?hl=en'),
];

/// Launches the terms of service URL.
///
/// Throws an exception if the URL cannot be launched.
Future<void> _termsUrl() async {
  if (!await launchUrl(_url[0])) throw 'Could not launch $_url';
}

/// Launches the privacy policy URL.
///
/// Throws an exception if the URL cannot be launched.
Future<void> _privacyUrl() async {
  if (!await launchUrl(_url[1])) throw 'Could not launch $_url';
}