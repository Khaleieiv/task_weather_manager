import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/domain/repositories/tasks_repository.dart';
import 'package:task_weather_manager/tasks/utils/custom_exception.dart';

class TasksPreferences extends TasksRepository {
  TasksPreferences({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  static const kTodosCollectionKey = 'tasks_key';

  final SharedPreferences _plugin;

  final _tasksStreamController =
      BehaviorSubject<List<TasksData>>.seeded(const []);

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final todosJson = _getValue(kTodosCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(
        json.decode(todosJson) as List,
      )
          .map(
            (jsonMap) => TasksData.fromJson(Map<String, dynamic>.from(jsonMap)),
          )
          .toList();
      _tasksStreamController.add(todos);
    } else {
      _tasksStreamController.add(const []);
    }
  }

  @override
  Future<int> clearCompleted() async {
    final task = [..._tasksStreamController.value];
    final completedTasksAmount = task.where((t) => t.isCompleted).length;
    task.removeWhere((t) => t.isCompleted);
    _tasksStreamController.add(task);
    await _setValue(kTodosCollectionKey, json.encode(task));
    return completedTasksAmount;
  }

  @override
  Future<void> deleteTasks(String id) {
    final task = [..._tasksStreamController.value];
    final taskIndex = task.indexWhere((t) => t.id == id);
    if (taskIndex == -1) {
      throw CustomResponseException("There are no tasks left");
    } else {
      task.removeAt(taskIndex);
      _tasksStreamController.add(task);
      return _setValue(kTodosCollectionKey, json.encode(task));
    }
  }

  @override
  Stream<List<TasksData>> getTasks() =>
      _tasksStreamController.asBroadcastStream();

  @override
  Future<void> saveTasks(TasksData tasks) {
    final task = [..._tasksStreamController.value];
    final taskIndex = task.indexWhere((t) => t.id == tasks.id);
    if (taskIndex >= 0) {
      task[taskIndex] = tasks;
    } else {
      task.add(tasks);
    }

    _tasksStreamController.add(task);
    return _setValue(kTodosCollectionKey, json.encode(task));
  }
}
