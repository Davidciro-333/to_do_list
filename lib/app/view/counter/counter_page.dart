import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count $_counter'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_counter < 10) {
                        _counter++;
                      }

                    });
                  },
                  child: const Icon(Icons.add_circle),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_counter > 0) {
                        _counter--;
                      }
                    });
                  },
                  //child: const Icon(Icons.exposure_minus_1_rounded),
                  child: const Icon(Icons.do_not_disturb_on_rounded),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
