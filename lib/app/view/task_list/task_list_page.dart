import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/repository/task_repository.dart';
import 'package:to_do_list/app/view/components/shape.dart';
import 'package:to_do_list/app/view/components/title.dart';

/// A page that displays a list of tasks.
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  /// Creates the mutable state for this widget.
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

/// The state for the TaskListPage.
class _TaskListPageState extends State<TaskListPage> {
  /// The list of tasks.
  final taskList = <Task>[];

  /// The repository for managing tasks.
  final TaskRepository taskRepository = TaskRepository();

  /// Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
  }

  @override

  /// Builds the widget tree for the task list page.
  ///
  /// The [context] parameter is used to look up the widget tree.
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // Aligns the children to the start of the main axis.
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // A header widget for the task list page.
            const _Header(),
            const Column(
              children: [
                Padding(
                  // Adds padding to the bottom of the row.
                  padding: EdgeInsets.only(bottom: 13),
                  child: Row(
                    // Aligns the children to the start of the main axis.
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        // Adds padding to the top and left of the text title.
                        padding: EdgeInsets.only(top: 24, left: 30),
                        // A text widget displaying the title 'Tasks'.
                        child: TextTitle('Tasks'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  // Fetches the list of tasks from the repository.
                  future: taskRepository.getTasks(),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

                    // Displays an error message if there is an error.
                    if (snapshot.hasError)
                      return const Center(child: Text('Error'));

                    // Displays a message if there are no tasks.
                    if (!snapshot.hasData || snapshot.data!.isEmpty)
                      return const Center(child: Text('No tasks'));

                    // Displays the list of tasks.
                    return _TaskList(
                      snapshot.data!,
                      // Callback function when a task's completion status changes.
                      onTaskDoneChange: (task) {
                        setState(() {
                          task.isCompleted = !task.isCompleted;
                          taskRepository.saveTasks(snapshot.data!);
                        });
                      },
                      // Callback function when a task is deleted.
                      onTaskDeleted: (task) {
                        setState(() {
                          taskList.remove(task);
                          taskRepository.saveTasks(taskList);
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Shows the modal to add a new task when the button is pressed.
        onPressed: () => _showTaskModal(context),
        // Sets the background color of the button.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Sets the icon of the button.
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// Shows the modal to add a new task.
  /// Shows the modal to add a new task.
  ///
  /// \param context The BuildContext in which the modal is shown.
  void _showTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => _NewTaskModal(
        /// Callback function when a new task is added.
        ///
        /// \param task The task that was added.
        onTaskAdded: (Task task) {
          // Adds the task to the repository.
          taskRepository.addTask(task);
          // Updates the state to include the new task in the task list.
          setState(() {
            taskList.add(task);
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
