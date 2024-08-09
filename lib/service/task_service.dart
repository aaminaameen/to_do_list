import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/model/task.dart';

class TaskStorageService {
  static const _tasksKey = 'tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_tasksKey, tasksJson);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);
    if (tasksJson == null) {
      return [];
    }
    final List<dynamic> tasksList = jsonDecode(tasksJson);
    return tasksList.map((taskJson) => Task.fromJson(taskJson)).toList();
  }
}
