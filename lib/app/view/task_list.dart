import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Data $count'),
              ElevatedButton(onPressed: (){
                setState(() {
                  count = 0;
                });
              }, child: const Text('Restart count')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          setState(() {
            count++;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
