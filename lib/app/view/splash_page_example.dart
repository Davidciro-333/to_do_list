import 'package:flutter/material.dart';
import 'package:to_do_list/app/view/app_bar.dart';
import 'package:to_do_list/app/view/convex_tab.dart';

class SplashPageExample extends StatelessWidget {
  const SplashPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBarCustom(title: const Text('To-Do List App')),
      body: Center(
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to the To-Do List App',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                color: Colors.orange,
                height: 128,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/Real-Madrid.png', height: 100, width: 100),
                    Image.asset('assets/images/ChampionsLeague.png', height: 80, width: 80),
                    Image.asset('assets/images/ManCity.png', height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ConvexTab(
              icon: Icons.home,
              title: 'Home',
              color: Colors.grey,
              activeColor: Colors.blue,
              active: true,
              onTap: () {},
            ),
            ConvexTab(
              icon: Icons.settings,
              title: 'Settings',
              color: Colors.grey,
              activeColor: Colors.blue,
              active: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}