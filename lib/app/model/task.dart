class Task {
  Task(
    this.title,
    this.description,
    {this.isCompleted = false}
  );

  Task.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
  }

  late final String title;
  late final String description;
  late bool isCompleted;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}