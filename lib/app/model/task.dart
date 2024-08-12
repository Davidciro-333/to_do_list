class Task {
  Task(
    this.title,
    {this.isCompleted = false}
  );

  Task.fromJson(Map<String, dynamic> json){
    title = json['title'];
    isCompleted = json['isCompleted'];
  }

  late final String title;
  late bool isCompleted;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}