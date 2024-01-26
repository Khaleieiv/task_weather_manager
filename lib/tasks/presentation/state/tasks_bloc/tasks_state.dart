part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

class TasksState extends Equatable {
  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.filter = TaskFilter.all,
    this.lastDeletedTask,
  });

  final TasksStatus status;
  final List<TasksData> tasks;
  final TaskFilter filter;
  final TasksData? lastDeletedTask;

  Iterable<TasksData> get filteredTodos => filter.applyAll(tasks);

  TasksState copyWith({
    TasksStatus Function()? status,
    List<TasksData> Function()? tasks,
    TaskFilter Function()? filter,
    TasksData? Function()? lastDeletedTask,
  }) {
    return TasksState(
      status: status != null ? status() : this.status,
      tasks: tasks != null ? tasks() : this.tasks,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTask:
          lastDeletedTask != null ? lastDeletedTask() : this.lastDeletedTask,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tasks,
        filter,
        lastDeletedTask,
      ];
}
