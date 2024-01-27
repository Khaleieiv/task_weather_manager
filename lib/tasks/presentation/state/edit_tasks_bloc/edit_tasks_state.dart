part of 'edit_tasks_bloc.dart';

enum EditTasksStatus { initial, loading, success, failure }

final class EditTasksState extends Equatable {
  const EditTasksState({
    this.status = EditTasksStatus.initial,
    this.initialTasks,
    this.title = '',
    this.category = '',
    this.description = '',
  });

  final EditTasksStatus status;
  final TasksData? initialTasks;
  final String title;
  final String category;
  final String description;

  bool get isNewTasks => initialTasks == null;

  EditTasksState copyWith({
    EditTasksStatus? status,
    TasksData? initialTasks,
    String? title,
    String? category,
    String? description,
  }) {
    return EditTasksState(
      status: status ?? this.status,
      initialTasks: initialTasks ?? this.initialTasks,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialTasks, title, description];
}

extension MyEditTasksStatus on EditTasksStatus {
  bool get isLoadingOrSuccess => [
    EditTasksStatus.loading,
    EditTasksStatus.success,
  ].contains(this);
}
