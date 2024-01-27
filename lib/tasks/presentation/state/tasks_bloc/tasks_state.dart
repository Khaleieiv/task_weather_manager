part of 'tasks_bloc.dart';

// TasksStatus represents the different states of the tasks.
enum TasksStatus { initial, loading, success, failure }

// TasksState is the state class for the TasksBloc,
// storing relevant information about tasks.
class TasksState extends Equatable {
  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.filter = TaskFilter.all,
    this.category = CategoryFilter.all,
    this.lastDeletedTask,
  });

  // Current status of the tasks.
  final TasksStatus status;

  // List of tasks.
  final List<TasksData> tasks;

  // Task filter.
  final TaskFilter filter;

  // Category filter.
  final CategoryFilter category;

  // The last deleted task, if any.
  final TasksData? lastDeletedTask;

  // Get filtered tasks based on the selected filter.
  Iterable<TasksData> get filteredTodos => filter.applyAll(tasks);

  // Get filtered tasks based on the selected category.
  Iterable<TasksData> get filteredCategory => category.applyAll(tasks);

  // Copy the current state with optional modifications.
  TasksState copyWith({
    TasksStatus Function()? status,
    List<TasksData> Function()? tasks,
    TaskFilter Function()? filter,
    CategoryFilter Function()? category,
    TasksData? Function()? lastDeletedTask,
  }) {
    return TasksState(
      status: status != null ? status() : this.status,
      tasks: tasks != null ? tasks() : this.tasks,
      filter: filter != null ? filter() : this.filter,
      category: category != null ? category() : this.category,
      lastDeletedTask:
      lastDeletedTask != null ? lastDeletedTask() : this.lastDeletedTask,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tasks,
    filter,
    category,
    lastDeletedTask,
  ];
}
