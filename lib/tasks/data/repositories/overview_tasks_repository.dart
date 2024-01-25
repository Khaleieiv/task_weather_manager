import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/domain/repositories/tasks_repository.dart';

class OverviewTasksRepository {
  final TasksRepository _tasksRepository;

  const OverviewTasksRepository({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  Stream<List<TasksData>> getTasks() => _tasksRepository.getTasks();

  Future<int> clearCompleted() => _tasksRepository.clearCompleted();

  Future<void> deleteTasks(String id) => _tasksRepository.deleteTasks(id);

  Future<void> saveTasks(TasksData tasks) => _tasksRepository.saveTasks(tasks);
}
