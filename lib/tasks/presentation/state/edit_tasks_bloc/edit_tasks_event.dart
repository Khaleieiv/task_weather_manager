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

final class EditTasksCategory extends EditTasksEvent {
  const EditTasksCategory(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}


final class EditTasksDescription extends EditTasksEvent {
  const EditTasksDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}
