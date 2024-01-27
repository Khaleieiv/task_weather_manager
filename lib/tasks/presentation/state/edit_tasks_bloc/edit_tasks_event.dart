part of 'edit_tasks_bloc.dart';

// EditTasksEvent is the base class for events related to editing tasks.
class EditTasksEvent extends Equatable {
  const EditTasksEvent();

  @override
  List<Object> get props => [];
}

// EditTasksSubmitted is an event indicating
// that the user has submitted the edited tasks.
class EditTasksSubmitted extends EditTasksEvent {
  const EditTasksSubmitted();
}

// EditTasksTitle is an event indicating
// that the title of the tasks has been changed.
class EditTasksTitle extends EditTasksEvent {
  const EditTasksTitle(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

// EditTasksCategory is an event indicating that the
// category of the tasks has been changed.
class EditTasksCategory extends EditTasksEvent {
  const EditTasksCategory(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

// EditTasksDescription is an event indicating that the d
// escription of the tasks has been changed.
class EditTasksDescription extends EditTasksEvent {
  const EditTasksDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}
