part of 'edit_tasks_bloc.dart';

// EditTasksStatus represents the different states of the edit tasks process.
enum EditTasksStatus { initial, loading, success, failure }

// EditTasksState is the state class for the EditTasksBloc,
// storing relevant information during editing tasks.
final class EditTasksState extends Equatable {
  const EditTasksState({
    this.status = EditTasksStatus.initial,
    this.initialTasks,
    this.title = '',
    this.category = '',
    this.description = '',
  });

  // Current status of the edit tasks process.
  final EditTasksStatus status;

  // Initial tasks data, if available.
  final TasksData? initialTasks;

  // Title of the tasks.
  final String title;

  // Category of the tasks.
  final String category;

  // Description of the tasks.
  final String description;

  // A helper method to check if the tasks are new or being edited.
  bool get isNewTasks => initialTasks == null;

  // Copy the current state with optional modifications.
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

// Extension for EditTasksStatus to simplify checking if the status
// indicates loading or success.
extension MyEditTasksStatus on EditTasksStatus {
  bool get isLoadingOrSuccess => [
    EditTasksStatus.loading,
    EditTasksStatus.success,
  ].contains(this);
}
