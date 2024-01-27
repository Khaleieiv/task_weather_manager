import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/domain/repositories/tasks_repository.dart';

// OverviewTasksRepository acts as a high-level abstraction for
// tasks-related operations.
class OverviewTasksRepository {
  // Tasks repository instance for handling low-level tasks data operations.
  final TasksRepository _tasksRepository;

  // Constructor to initialize OverviewTasksRepository with
  // a TasksRepository instance.
  const OverviewTasksRepository({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  // Stream to get a list of tasks.
  Stream<List<TasksData>> getTasks() => _tasksRepository.getTasks();

  // Clear completed tasks and return the number of tasks cleared.
  Future<int> clearCompleted() => _tasksRepository.clearCompleted();

  // Delete tasks by ID.
  Future<void> deleteTasks(String id) => _tasksRepository.deleteTasks(id);

  // Save tasks data.
  Future<void> saveTasks(TasksData tasks) => _tasksRepository.saveTasks(tasks);
}
