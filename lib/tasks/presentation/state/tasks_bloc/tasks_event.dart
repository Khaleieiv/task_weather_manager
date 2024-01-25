part of 'tasks_bloc.dart';

@immutable
class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

final class TasksSubscription extends TasksEvent {
  const TasksSubscription();
}

final class TasksTodoCompletion extends TasksEvent {
  const TasksTodoCompletion({
    required this.task,
    required this.isCompleted,
  });

  final TasksData task;
  final bool isCompleted;

  @override
  List<Object> get props => [task, isCompleted];
}

final class TasksDeleted extends TasksEvent {
  const TasksDeleted(this.task);

  final TasksData task;

  @override
  List<Object> get props => [task];
}

final class TasksUndoDeletion extends TasksEvent {
  const TasksUndoDeletion();
}

class TasksFilter extends TasksEvent {
  const TasksFilter(this.filter);

  final TasksFilter filter;

  @override
  List<Object> get props => [filter];
}

class TasksClearCompleted extends TasksEvent {
  const TasksClearCompleted();
}
