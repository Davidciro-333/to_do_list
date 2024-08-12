import 'package:flutter/material.dart';
import 'package:to_do_list/app/view/components/title.dart';
import 'package:to_do_list/app/view/task_list/task_list_page.dart';
//import 'package:to_do_list/app/view/task_list/task_list_page_example.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/shape.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Shape()]),
            Padding(
              padding: const EdgeInsets.only(top: 72, bottom: 100),
              child: Image.asset(
                'assets/images/onboarding-image.png',
              ),
            ),
            const TextTitle('Task list'),
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
            const Spacer(),
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

final List<Uri> _url = [
  Uri.parse('https://docs.flutter.dev/tos'),
  Uri.parse('https://policies.google.com/privacy?hl=en'),
];

Future<void> _termsUrl() async {
  if (!await launchUrl(_url[0])) throw 'Could not launch $_url';
}

Future<void> _privacyUrl() async {
  if (!await launchUrl(_url[1])) throw 'Could not launch $_url';
}
