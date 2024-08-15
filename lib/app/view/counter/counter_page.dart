import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/view/counter/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider()..increment(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CounterProvider>(
                builder: (context, counterProvider, child) {
                  return Text('Count ${counterProvider.counter}');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          if (context.read<CounterProvider>().counter < 10) {
                            context.read<CounterProvider>().increment();
                          }
                        },
                        child: const Icon(Icons.add_circle),
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          if (context.read<CounterProvider>().counter > 0) {
                            context.read<CounterProvider>().decrement();
                          }
                        },
                        //child: const Icon(Icons.exposure_minus_1_rounded),
                        child: const Icon(Icons.do_not_disturb_on_rounded),
                      );
                    }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
