import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

// TasksRepository is an abstract class defining operations for tasks data.
abstract class TasksRepository {
  // Stream to get a list of tasks.
  Stream<List<TasksData>> getTasks();

  // Save tasks data.
  Future<void> saveTasks(TasksData tasks);

  // Delete tasks by ID.
  Future<void> deleteTasks(String id);

  // Clear completed tasks and return the number of tasks cleared.
  Future<int> clearCompleted();
}
