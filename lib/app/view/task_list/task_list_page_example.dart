import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/repository/task_repository.dart';
import 'package:to_do_list/app/view/components/shape.dart';
import 'package:to_do_list/app/view/components/title.dart';

/// A stateful widget that represents an example task list page.
class TaskListPageExample extends StatefulWidget {
  /// Creates a [TaskListPageExample] widget.
  const TaskListPageExample({super.key});

  /// Creates the mutable state for this widget.
  @override
  State<TaskListPageExample> createState() => _TaskListPageExampleState();
}

/// The state for the [TaskListPageExample] widget.
class _TaskListPageExampleState extends State<TaskListPageExample> {
  /// A list of tasks.
  final taskList = <Task>[];

  /// An instance of [TaskRepository] to manage tasks.
  final TaskRepository taskRepository = TaskRepository();

  /// Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
  }

  /// Builds the widget tree for the task list page.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A widget that provides a safe area for the content.
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // A header widget for the task list page.
            const _Header(),
            // A column containing the title of the task list.
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
            // An expanded widget that contains the list of tasks.
            Expanded(
              child: FutureBuilder(
                  // Fetches the list of tasks from the repository.
                  future: taskRepository.getTasks(),
                  builder: (context, snapshot) {
                    // Displays an error message if there is an error.
                    if (snapshot.hasError)
                      return const Center(child: Text('Error'));

                    // Displays a message if there are no tasks.
                    if (!snapshot.hasData || snapshot.data!.isEmpty)
                      return const Center(child: Text('No tasks'));

                    // Displays the list of tasks.
                    return _TaskList(
                      snapshot.data!,
                      // Callback function to handle task completion status change.
                      onTaskDoneChange: (task) {
                        setState(() {
                          // Toggles the completion status of the task.
                          task.isCompleted = !task.isCompleted;
                          // Saves the updated task list to the repository.
                          taskRepository.saveTasks(snapshot.data!);
                        });
                      },
                      // Callback function to handle task deletion.
                      onTaskDeleted: (task) {
                        setState(() {
                          // Removes the task from the task list.
                          taskList.remove(task);
                          // Saves the updated task list to the repository.
                          taskRepository.saveTasks(taskList);
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      // A floating action button to add a new task.
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// Displays a modal bottom sheet to add a new task.
  ///
  /// The [context] parameter is used to look up the widget tree.
  void _showTaskModal(BuildContext context) {
    showModalBottomSheet(
      // The BuildContext to use for locating the widget tree.
      context: context,
      // The builder function to create the modal's content.
      builder: (_) => _NewTaskModal(
        // Callback function to handle the addition of a new task.
        onTaskAdded: (Task task) {
          setState(() {
            // Adds the new task to the task list.
            taskList.add(task);
            // Saves the updated task list to the repository.
            taskRepository.saveTasks(taskList);
          });
        },
      ),
      // Allows the modal to be scrollable.
      isScrollControlled: true,
    );
  }
}

/// A stateful widget that represents a modal for adding a new task.
class _NewTaskModal extends StatefulWidget {
  /// Creates a [_NewTaskModal] widget.
  const _NewTaskModal({required this.onTaskAdded});

  /// A callback function to handle task addition.
  final void Function(Task task) onTaskAdded;

  /// Creates the mutable state for this widget.
  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

/// The state for the [_NewTaskModal] widget.
class _NewTaskModalState extends State<_NewTaskModal> {
  /// A controller for the task title input field.
  final _controllerTitle = TextEditingController();

  /// A controller for the task description input field.
  final _controllerDes = TextEditingController();

  /// Disposes the controllers when the widget is removed from the widget tree.
  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDes.dispose();
    super.dispose();
  }

  /// Builds the widget tree for the new task modal.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Adds padding to the bottom of the container to account for the view insets.
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // Sets the width of the container to the maximum finite width.
        width: double.maxFinite,
        // Applies a vertical border radius to the top of the container.
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        ),
        child: Column(
          // Aligns the children to the start of the cross axis.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Minimizes the main axis size of the column.
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              // Adds padding to the top and left of the text title.
              padding: EdgeInsets.only(top: 24, left: 35),
              // A text widget displaying the title 'New Task'.
              child: TextTitle('New Task'),
            ),
            Padding(
              // Adds padding to the top, left, and right of the text field.
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30),
              child: TextField(
                // Enables autofocus for the text field.
                autofocus: true,
                // Sets the action button on the keyboard to 'Next'.
                textInputAction: TextInputAction.next,
                // Capitalizes the first letter of each sentence.
                textCapitalization: TextCapitalization.sentences,
                // Sets the keyboard type to text.
                keyboardType: TextInputType.text,
                // Binds the controller to the text field.
                controller: _controllerTitle,
                // Sets the decoration for the text field.
                decoration: InputDecoration(
                  // Fills the text field with a background color.
                  filled: true,
                  // Sets the hint text for the text field.
                  hintText: 'Task name',
                  // Sets the border style for the text field.
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              // Adds padding to the top, left, and right of the text field.
              padding: const EdgeInsets.only(top: 24, left: 35, right: 30),
              child: TextField(
                // Enables autofocus for the text field.
                autofocus: true,
                // Sets the action button on the keyboard to 'Go'.
                textInputAction: TextInputAction.go,
                // Capitalizes the first letter of each sentence.
                textCapitalization: TextCapitalization.sentences,
                // Sets the keyboard type to text.
                keyboardType: TextInputType.text,
                // Binds the controller to the text field.
                controller: _controllerDes,
                // Sets the decoration for the text field.
                decoration: InputDecoration(
                  // Fills the text field with a background color.
                  filled: true,
                  // Sets the hint text for the text field.
                  hintText: 'Description (optional)',
                  // Sets the border style for the text field.
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              // Adds padding to the top, left, right, and bottom of the button.
              padding: const EdgeInsets.only(
                  top: 24, left: 35, right: 30, bottom: 30),
              child: ElevatedButton(
                // Sets the background color of the button.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                // Defines the callback function when the button is pressed.
                onPressed: () {
                  if (_controllerTitle.text.isNotEmpty ||
                      _controllerDes.text.isNotEmpty) {
                    final task =
                    Task(_controllerTitle.text, _controllerDes.text);
                    widget.onTaskAdded(task);
                    Navigator.of(context).pop();
                  }
                },
                // Sets the text of the button.
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

/// A stateless widget that represents a list of tasks.
class _TaskList extends StatelessWidget {
  /// Creates a [_TaskList] widget.
  const _TaskList(this.taskList,
      {required this.onTaskDoneChange, required this.onTaskDeleted});

  /// A list of tasks.
  final List<Task> taskList;

  /// A callback function to handle task completion status change.
  final void Function(Task task) onTaskDoneChange;

  /// A callback function to handle task deletion.
  final void Function(Task task) onTaskDeleted;

  /// Builds the widget tree for the task list.
  ///
  /// The [context] parameter is used to look up the widget tree.
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
        itemCount: taskList.length,
      ),
    );
  }
}

/// A stateless widget that represents the header of the task list page.
class _Header extends StatelessWidget {
  /// Creates a [_Header] widget.
  const _Header();

  /// Builds the widget tree for the header.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return Container(
      // Sets the width of the container to the maximum finite width.
      width: double.maxFinite,
      // Sets the background color of the container to the primary color of the theme.
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          // A row containing a shape widget.
          const Row(
            children: [Shape()],
          ),
          Column(
            children: [
              Padding(
                // Adds padding to the bottom of the image.
                padding: const EdgeInsets.only(bottom: 24),
                child: Image.asset(
                  'assets/images/tasks-list-image.png',
                  // Sets the width of the image.
                  width: 120,
                  // Sets the height of the image.
                  height: 120,
                ),
              ),
              const Padding(
                // Adds padding to the bottom of the text.
                padding: EdgeInsets.only(bottom: 24),
                // A text widget displaying the title with white color.
                child: TextTitle('Complete your tasks', color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A stateful widget that represents a single task item.
class _TaskItem extends StatefulWidget {
  /// Creates a [_TaskItem] widget.
  const _TaskItem(this.task, {this.onTaskDoneChange, this.onTaskDeleted});

  /// The task associated with this item.
  final Task task;

  /// A callback function to handle task completion status change.
  final VoidCallback? onTaskDoneChange;

  /// A callback function to handle task deletion.
  final VoidCallback? onTaskDeleted;

  /// Creates the mutable state for this widget.
  @override
  State<_TaskItem> createState() => _TaskItemState();
}

/// The state for the [_TaskItem] widget.
class _TaskItemState extends State<_TaskItem> {
  /// Builds the widget tree for the task item.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detects gestures on the task item.
      onTap: widget.onTaskDoneChange,
      child: Card(
        // A card widget to display the task item.
        child: ListTile(
          // Displays the title of the task.
          title: Text(widget.task.title),
          // Displays the description of the task.
          subtitle: Text(widget.task.description),
          // Displays an icon indicating the completion status of the task.
          leading: Icon(
            widget.task.isCompleted
                ? Icons.check
                : Icons.check_box_outline_blank,
            color: Theme.of(context).colorScheme.primary,
          ),
          // An icon button to delete the task.
          trailing: IconButton(
            icon: Icon(Icons.delete,
                color: Theme.of(context).colorScheme.primary),
            onPressed: widget.onTaskDeleted,
          ),
        ),
      ),
    );
  }
}




