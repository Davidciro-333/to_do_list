class Task {
  Task(
    this.title,
    {this.isCompleted = false}
  );

  final String title;
  bool isCompleted;
}