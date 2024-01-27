import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/utils/category_filter.dart';
import 'package:task_weather_manager/tasks/utils/task_filter.dart';

// Part file containing the TasksEvent and TasksState classes.
part 'tasks_event.dart';
part 'tasks_state.dart';

// TasksBloc is responsible for managing the state
// and handling events related to tasks.
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  // Repository for handling tasks data operations.
  final OverviewTasksRepository _tasksRepository;

  // Constructor to initialize the TasksBloc with the required dependencies.
  TasksBloc({
    required OverviewTasksRepository tasksRepository,
  })  : _tasksRepository = tasksRepository,
  // Initialize the state with default values.
        super(const TasksState()) {
    // Event handlers for various tasks-related events.
    on<TasksSubscription>(_onSubscription);
    on<TasksCompletion>(_onTasksCompletion);
    on<TasksDeleted>(_onTasksDeleted);
    on<TasksUndoDeletion>(_onUndoDeletion);
    on<TasksFilter>(_onFilter);
    on<CategoriesFilter>(_onCategory);
    on<TasksClearCompleted>(_onClearCompleted);
  }

  // Event handler for tasks subscription, fetching and updating tasks data.
  Future<void> _onSubscription(
      TasksSubscription event,
      Emitter<TasksState> emit,
      ) async {
    // Update state to indicate loading.
    emit(state.copyWith(status: () => TasksStatus.loading));

    // Fetch tasks data and update the state accordingly.
    await emit.forEach<List<TasksData>>(
      _tasksRepository.getTasks(),
      onData: (tasks) => state.copyWith(
        status: () => TasksStatus.success,
        tasks: () => tasks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TasksStatus.failure,
      ),
    );
  }

  // Event handler for updating the completion status of tasks.
  Future<void> _onTasksCompletion(
      TasksCompletion event,
      Emitter<TasksState> emit,
      ) async {
    // Create a new task with the updated completion status.
    final newTask = event.task.copyWith(isCompleted: event.isCompleted);
    await _tasksRepository.saveTasks(newTask);
  }

  // Event handler for deleting tasks.
  Future<void> _onTasksDeleted(
      TasksDeleted event,
      Emitter<TasksState> emit,
      ) async {
    // Update state with the last deleted task and
    // delete it from the repository.
    emit(state.copyWith(lastDeletedTask: () => event.task));
    await _tasksRepository.deleteTasks(event.task.id);
  }

  // Event handler for undoing task deletion.
  Future<void> _onUndoDeletion(
      TasksUndoDeletion event,
      Emitter<TasksState> emit,
      ) async {
    // Ensure there is a task to undo deletion.
    assert(
    state.lastDeletedTask != null,
    'No more tasks to delete',
    );

    // Retrieve the last deleted task, update state,
    // and save it back to the repository.
    final task = state.lastDeletedTask!;
    emit(state.copyWith(lastDeletedTask: () => null));
    await _tasksRepository.saveTasks(task);
  }

  // Event handler for updating task filter.
  void _onFilter(
      TasksFilter event,
      Emitter<TasksState> emit,
      ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  // Event handler for updating category filter.
  void _onCategory(
      CategoriesFilter event,
      Emitter<TasksState> emit,
      ) {
    emit(state.copyWith(category: () => event.category));
  }

  // Event handler for clearing completed tasks.
  Future<void> _onClearCompleted(
      TasksClearCompleted event,
      Emitter<TasksState> emit,
      ) async {
    // Clear completed tasks from the repository.
    await _tasksRepository.clearCompleted();
  }
}
