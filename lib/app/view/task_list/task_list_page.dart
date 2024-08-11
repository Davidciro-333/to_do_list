import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/view/components/shape.dart';
import 'package:to_do_list/app/view/components/title.dart';

class Counter {
  static int count = taskList.length;
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const _Header(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 30),
                        child: TextTitle('Tasks ${Counter.count}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const _TaskList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Counter.count++;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList();

  @override
  State<_TaskList> createState() => _TaskListState();
}

final taskList = <Task>[
  Task('Sacar la basura'),
  Task('Lavar baño'),
  Task('Curso flutter'),
  Task('Dormir siesta'),
  Task('Ver pelicula'),
  Task('Comer'),
];

class _TaskListState extends State<_TaskList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.separated(
          itemBuilder: (_, index) => _TaskItem(taskList[index], onTap: () {
                taskList[index].isCompleted = !taskList[index].isCompleted;
                setState(() {
                  //Counter.count--;
                });
              }),
          separatorBuilder: (_, __) =>
              const Padding(padding: EdgeInsets.only(top: 16)),
          itemCount: taskList.length),
    ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [Shape()]),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Image.asset('assets/images/tasks-list-image.png',
                    width: 120, height: 120),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: TextTitle('Complete your tasks', color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TaskItem extends StatefulWidget {
  const _TaskItem(this.task, {this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: ListTile(
          title: Text('Task: ${widget.task.title}'),
          leading: IconButton(
              onPressed: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                if (Counter.count > 0) {
                  Counter.count--;
                }
                setState(() {});
              },
              icon: widget.task.isCompleted
                  ? const Icon(Icons.check_box_rounded)
                  : const Icon(Icons.check_box_outline_blank)),
        ),
      ),
    );
  }
}
