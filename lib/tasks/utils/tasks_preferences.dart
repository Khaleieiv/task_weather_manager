import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/domain/repositories/tasks_repository.dart';
import 'package:task_weather_manager/tasks/utils/custom_exception.dart';

// TasksPreferences is a concrete implementation of
// TasksRepository that uses SharedPreferences
// to persist tasks data. It extends the TasksRepository abstract class.
class TasksPreferences extends TasksRepository {
  // SharedPreferences instance used for storing tasks data.
  final SharedPreferences _plugin;

  // BehaviorSubject to handle the stream of tasks data.
  final _tasksStreamController =
      BehaviorSubject<List<TasksData>>.seeded(const []);

  // Key for storing tasks data in SharedPreferences.
  static const kTodosCollectionKey = 'tasks_key';

  // Constructor for TasksPreferences, initializing
  // with a SharedPreferences instance.
  TasksPreferences({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    // Initialize the tasks stream.
    _init();
  }

  // Private method to get a value from SharedPreferences by key.
  String? _getValue(String key) => _plugin.getString(key);

  // Private method to set a value in SharedPreferences with a key.
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  // Initialization method to load tasks data
  // from SharedPreferences and add it to the stream.
  void _init() {
    // Retrieve tasks data in JSON format from SharedPreferences.
    final todosJson = _getValue(kTodosCollectionKey);

    // If tasks data exists, decode and convert it to
    // a list of TasksData objects.
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
      // If no tasks data exists, initialize the stream with an empty list.
      _tasksStreamController.add(const []);
    }
  }

  // Override method to clear completed tasks.
  @override
  Future<int> clearCompleted() async {
    final task = [..._tasksStreamController.value];
    final completedTasksAmount = task.where((t) => t.isCompleted).length;
    task.removeWhere((t) => t.isCompleted);
    _tasksStreamController.add(task);
    await _setValue(kTodosCollectionKey, json.encode(task));
    return completedTasksAmount;
  }

  // Override method to delete tasks by ID.
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

  // Override method to get the stream of tasks data.
  @override
  Stream<List<TasksData>> getTasks() =>
      _tasksStreamController.asBroadcastStream();

  // Override method to save tasks data.
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
