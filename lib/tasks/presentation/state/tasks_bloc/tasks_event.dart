part of 'tasks_bloc.dart';

// TasksEvent is the base class for events related to tasks.
@immutable
class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

// TasksSubscription is an event indicating
// a request to subscribe to tasks updates.
final class TasksSubscription extends TasksEvent {
  const TasksSubscription();
}

// TasksCompletion is an event indicating
// that the completion status of a task has changed.
final class TasksCompletion extends TasksEvent {
  const TasksCompletion({
    required this.task,
    required this.isCompleted,
  });

  final TasksData task;
  final bool isCompleted;

  @override
  List<Object> get props => [task, isCompleted];
}

// TasksDeleted is an event indicating that a task has been deleted.
final class TasksDeleted extends TasksEvent {
  const TasksDeleted(this.task);

  final TasksData task;

  @override
  List<Object> get props => [task];
}

// TasksUndoDeletion is an event indicating
// a request to undo the last task deletion.
final class TasksUndoDeletion extends TasksEvent {
  const TasksUndoDeletion();
}

// CategoriesFilter is an event indicating
// a change in category filter for tasks.
class CategoriesFilter extends TasksEvent {
  const CategoriesFilter(this.category);

  final CategoryFilter category;

  @override
  List<Object> get props => [category];
}

// TasksFilter is an event indicating a change in task filter for tasks.
class TasksFilter extends TasksEvent {
  const TasksFilter(this.filter);

  final TaskFilter filter;

  @override
  List<Object> get props => [filter];
}

// TasksClearCompleted is an event indicating
// a request to clear completed tasks.
class TasksClearCompleted extends TasksEvent {
  const TasksClearCompleted();
}
