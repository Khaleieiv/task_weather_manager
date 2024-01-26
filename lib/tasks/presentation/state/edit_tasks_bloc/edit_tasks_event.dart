part of 'edit_tasks_bloc.dart';

class EditTasksEvent extends Equatable {
  const EditTasksEvent();

  @override
  List<Object> get props => [];
}

final class EditTasksSubmitted extends EditTasksEvent {
  const EditTasksSubmitted();
}

final class EditTasksTitle extends EditTasksEvent {
  const EditTasksTitle(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class EditTasksDescription extends EditTasksEvent {
  const EditTasksDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}
