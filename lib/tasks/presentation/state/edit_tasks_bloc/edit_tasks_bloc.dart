import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

part 'edit_tasks_state.dart';

part 'edit_tasks_event.dart';

class EditTasksBloc extends Bloc<EditTasksEvent, EditTasksState> {
  EditTasksBloc({
    required OverviewTasksRepository tasksRepository,
    required TasksData? initialTasks,
  })  : _tasksRepository = tasksRepository,
        super(
          EditTasksState(
            initialTasks: initialTasks,
            title: initialTasks?.title ?? '',
            category: initialTasks?.category ?? '',
            description: initialTasks?.description ?? '',
          ),
        ) {
    on<EditTasksSubmitted>(_onSubmitted);
    on<EditTasksTitle>(_onTitleChanged);
    on<EditTasksCategory>(_onCategoryChanged);
    on<EditTasksDescription>(_onDescriptionChanged);
  }

  final OverviewTasksRepository _tasksRepository;

  Future<void> _onSubmitted(
    EditTasksSubmitted event,
    Emitter<EditTasksState> emit,
  ) async {
    emit(state.copyWith(status: EditTasksStatus.loading));
    final tasks =
        (state.initialTasks ?? TasksData(title: '')).copyWith(
      title: state.title,
      category: state.category,
      description: state.description,
    );

    try {
      await _tasksRepository.saveTasks(tasks);
      emit(state.copyWith(status: EditTasksStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTasksStatus.failure));
    }
  }

  void _onTitleChanged(
    EditTasksTitle event,
    Emitter<EditTasksState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onCategoryChanged(
      EditTasksCategory event,
      Emitter<EditTasksState> emit,
      ) {
    emit(state.copyWith(category: event.category));
  }

  void _onDescriptionChanged(
    EditTasksDescription event,
    Emitter<EditTasksState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }
}
