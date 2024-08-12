import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/repository/task_repository.dart';
import 'package:to_do_list/app/view/components/shape.dart';
import 'package:to_do_list/app/view/components/title.dart';

class TaskListPageExample extends StatefulWidget {
  const TaskListPageExample({super.key});

  @override
  State<TaskListPageExample> createState() => _TaskListPageExampleState();
}

class _TaskListPageExampleState extends State<TaskListPageExample> {
  final taskList = <Task>[];
  final TaskRepository taskRepository = TaskRepository();

  @override
  void initState() {
    super.initState();
  }

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
            Expanded(
              child: FutureBuilder(
                  future: taskRepository.getTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return const Center(child: Text('Error'));

                    if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('No tasks'));

                    return _TaskList(
                      snapshot.data!,
                      onTaskDoneChange: (task) {
                        setState(() {
                          task.isCompleted = !task.isCompleted;
                          taskRepository.saveTasks(snapshot.data!);
                        });
                      },
                      onTaskDeleted: (task) {
                        setState(() {
                          taskList.remove(task);
                          taskRepository.saveTasks(taskList);
                        });
                      },
                    );
                  }
              ),
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
    showModalBottomSheet(
      context: context,
      builder: (_) => _NewTaskModal(
        onTaskAdded: (Task task) {
          setState(() {
            taskList.add(task);
            taskRepository.saveTasks(taskList);
          });
        },
      ),
      isScrollControlled: true,
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList(this.taskList, {required this.onTaskDoneChange, required this.onTaskDeleted});

  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;
  final void Function(Task task) onTaskDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: ListView.separated(
          itemBuilder: (_, index) => _TaskItem(
            taskList[index],
            onTaskDoneChange: () => onTaskDoneChange(taskList[index]),
            onTaskDeleted: () => onTaskDeleted(taskList[index]),
          ),
          separatorBuilder: (_, __) =>
          const Padding(padding: EdgeInsets.only(top: 16)),
          itemCount: taskList.length),
    );
  }
}

class _TaskItem extends StatefulWidget {
  const _TaskItem(this.task, {this.onTaskDoneChange, this.onTaskDeleted});

  final Task task;
  final VoidCallback? onTaskDoneChange;
  final VoidCallback? onTaskDeleted;

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTaskDoneChange,
      child: Card(
        child: ListTile(
          title: Text(widget.task.title),
          //subtitle: Text(widget.task.isCompleted ? 'Completed' : 'Pending'),
          subtitle: Text(widget.task.description),
          leading: Icon(
            widget.task.isCompleted
                ? Icons.check
                : Icons.check_box_outline_blank,
            color: Theme.of(context).colorScheme.primary,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primary,),
            onPressed: widget.onTaskDeleted,
          ),
        ),
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

class _NewTaskModal extends StatefulWidget {
  const _NewTaskModal({required this.onTaskAdded});

  final void Function(Task task) onTaskAdded;

  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<_NewTaskModal> {
  final _controllerTitle = TextEditingController();
  final _controllerDes = TextEditingController();

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.maxFinite,
        //height: 286,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24, left: 35),
              child: TextTitle('New Task'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                controller: _controllerTitle,
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
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.go,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                controller: _controllerDes,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Description (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30, bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (_controllerTitle.text.isNotEmpty || _controllerDes.text.isNotEmpty) {
                    final task = Task(_controllerTitle.text, _controllerDes.text);
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