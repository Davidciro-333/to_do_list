import 'package:flutter/material.dart';
import 'package:to_do_list/app/view/components/title.dart';
import 'package:to_do_list/app/view/task_list/task_list_page.dart';

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
               children: [
                 Shape()
               ]
            ),
            Padding(
              padding: const EdgeInsets.only(top: 72, bottom: 100),
              child: Image.asset('assets/images/onboarding-image.png', ),
            ),
            const TextTitle('Task list'),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const TaskListPage();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 21, left: 32, right: 32),
                child: Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}