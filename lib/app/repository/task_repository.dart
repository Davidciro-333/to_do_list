import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/app/model/task.dart';

/// A repository class for managing tasks using shared preferences.
class TaskRepository {
  /// Adds a [Task] to the list of tasks stored in shared preferences.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether
  /// the task was successfully added.
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTasks);
  }

  /// Retrieves the list of tasks from shared preferences.
  ///
  /// Returns a [Future] that completes with a list of [Task] objects.
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    return jsonTasks
        .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
        .toList();
  }

  /// Saves a list of [Task] objects to shared preferences.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether
  /// the tasks were successfully saved.
  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTasks);
  }

  /// Removes a [Task] from the list of tasks stored in shared preferences.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether
  /// the task was successfully removed.
  Future<bool> removeTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.remove(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTasks);
  }
}