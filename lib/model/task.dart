class Task {
  String title;
  DateTime date;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    this.isCompleted = false,
    
  });

  
  Task copyWith({
    String? title,
    
    DateTime? date,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
    
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  List<Object?> get props => [title, date, isCompleted];
}
