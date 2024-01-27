import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

// Part file containing the EditTasksState class.
part 'edit_tasks_state.dart';

// Part file containing the EditTasksEvent class.
part 'edit_tasks_event.dart';

// EditTasksBloc is responsible for managing the state
// and handling events related to editing tasks.
class EditTasksBloc extends Bloc<EditTasksEvent, EditTasksState> {
  // Constructor to initialize the EditTasksBloc with required dependencies.
  EditTasksBloc({
    required OverviewTasksRepository tasksRepository,
    required TasksData? initialTasks,
  })  : _tasksRepository = tasksRepository,
  // Initialize the state with the provided or default values.
        super(
        EditTasksState(
          initialTasks: initialTasks,
          title: initialTasks?.title ?? '',
          category: initialTasks?.category ?? '',
          description: initialTasks?.description ?? '',
        ),
      ) {
    // Event handlers for various edit-related events.
    on<EditTasksSubmitted>(_onSubmitted);
    on<EditTasksTitle>(_onTitleChanged);
    on<EditTasksCategory>(_onCategoryChanged);
    on<EditTasksDescription>(_onDescriptionChanged);
  }

  // Tasks repository instance for handling tasks data operations.
  final OverviewTasksRepository _tasksRepository;

  // Event handler for when the user submits edited tasks.
  Future<void> _onSubmitted(
      EditTasksSubmitted event,
      Emitter<EditTasksState> emit,
      ) async {
    // Update state to indicate loading.
    emit(state.copyWith(status: EditTasksStatus.loading));

    // Create or update tasks data based on user input.
    final tasks =
    (state.initialTasks ?? TasksData(title: '')).copyWith(
      title: state.title,
      category: state.category,
      description: state.description,
    );

    try {
      // Save the edited tasks data.
      await _tasksRepository.saveTasks(tasks);
      emit(state.copyWith(status: EditTasksStatus.success));
    } catch (e) {
      // Handle failure by updating the state.
      emit(state.copyWith(status: EditTasksStatus.failure));
    }
  }

  // Event handler for when the title is changed.
  void _onTitleChanged(
      EditTasksTitle event,
      Emitter<EditTasksState> emit,
      ) {
    emit(state.copyWith(title: event.title));
  }

  // Event handler for when the category is changed.
  void _onCategoryChanged(
      EditTasksCategory event,
      Emitter<EditTasksState> emit,
      ) {
    emit(state.copyWith(category: event.category));
  }

  // Event handler for when the description is changed.
  void _onDescriptionChanged(
      EditTasksDescription event,
      Emitter<EditTasksState> emit,
      ) {
    emit(state.copyWith(description: event.description));
  }
}
