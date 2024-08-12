import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/view/components/shape.dart';
import 'package:to_do_list/app/view/components/title.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final taskList = <Task>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const _Header(),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24, left: 30),
                        child: TextTitle('Tasks'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _TaskList(
              taskList,
              onTaskDoneChange: (task) {
                setState(() {
                  task.isCompleted = !task.isCompleted;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showTaskModal(BuildContext context) {
    true;
    showModalBottomSheet(
      context: context,
      builder: (_) => _NewTaskModal(
        onTaskAdded: (Task task) {
          setState(() {
            taskList.add(task);
          });
        },
      ),
      isScrollControlled: true,
    );
  }
}

class _NewTaskModal extends StatefulWidget {
  _NewTaskModal({required this.onTaskAdded});

  final void Function(Task task) onTaskAdded;

  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<_NewTaskModal> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.maxFinite,
        height: 228,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24, left: 35),
              child: TextTitle('New Task'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.go,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                keyboardAppearance: Brightness.light,
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Task name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    final task = Task(_controller.text);
                    widget.onTaskAdded(task);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList(this.taskList, {required this.onTaskDoneChange});

  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: ListView.separated(
            itemBuilder: (_, index) => _TaskItem(
                  taskList[index],
                  onTap: () => onTaskDoneChange(taskList[index]),
                ),
            separatorBuilder: (_, __) =>
                const Padding(padding: EdgeInsets.only(top: 16)),
            itemCount: taskList.length),
      ),
    );
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
          title: Text(widget.task.title),
          leading: Icon(
            widget.task.isCompleted
                ? Icons.check
                : Icons.check_box_outline_blank,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
