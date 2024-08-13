/// A class representing a task with a title, description, and completion status.
class Task {
  /// Creates a [Task] with the given [title], [description], and optional [isCompleted] status.
  ///
  /// The [isCompleted] parameter defaults to false if not provided.
  Task(
      this.title,
      this.description,
      {this.isCompleted = false}
      );

  /// Creates a [Task] from a JSON object.
  ///
  /// The [json] parameter must contain the keys 'title', 'description', and 'isCompleted'.
  Task.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
  }

  /// The title of the task.
  late final String title;

  /// The description of the task.
  late final String description;

  /// The completion status of the task.
  late bool isCompleted;

  /// Converts the [Task] to a JSON object.
  ///
  /// Returns a map containing the keys 'title', 'description', and 'isCompleted'.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}