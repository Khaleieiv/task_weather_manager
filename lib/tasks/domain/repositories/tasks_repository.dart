import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

abstract class TasksRepository {
  const TasksRepository();

  Stream<List<TasksData>> getTasks();

  Future<void> saveTasks(TasksData tasks);

  Future<void> deleteTasks(String id);

  Future<int> clearCompleted();
}
