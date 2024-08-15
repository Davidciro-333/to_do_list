import 'package:flutter/material.dart';
import 'package:to_do_list/app/model/task.dart';
import 'package:to_do_list/app/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  final TaskRepository _taskRepository = TaskRepository();

  Future<void> fetchTasks() async {
    /// Fetch tasks from the repository
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  List<Task> get taskList => _taskList;

  /*void onTaskAdded(Task task) {
    _taskList.add(task);
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }*/

  void onTaskAdded(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
    notifyListeners();
  }

  void onTaskDoneChange(Task task) {
    task.isCompleted = !task.isCompleted;
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }

  onTaskDeleted(Task task) {
    _taskList.remove(task);
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }
}