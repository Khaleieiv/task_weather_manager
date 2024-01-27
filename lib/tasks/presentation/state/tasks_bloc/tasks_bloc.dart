import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/utils/category_filter.dart';
import 'package:task_weather_manager/tasks/utils/task_filter.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final OverviewTasksRepository _tasksRepository;

  TasksBloc({
    required OverviewTasksRepository tasksRepository,
  })  : _tasksRepository = tasksRepository,
        super(const TasksState()) {
    on<TasksSubscription>(_onSubscription);
    on<TasksCompletion>(_onTasksCompletion);
    on<TasksDeleted>(_onTasksDeleted);
    on<TasksUndoDeletion>(_onUndoDeletion);
    on<TasksFilter>(_onFilter);
    on<CategoriesFilter>(_onCategory);
    on<TasksClearCompleted>(_onClearCompleted);
  }

  Future<void> _onSubscription(
    TasksSubscription event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: () => TasksStatus.loading));

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

  Future<void> _onTasksCompletion(
    TasksCompletion event,
    Emitter<TasksState> emit,
  ) async {
    final newTask = event.task.copyWith(isCompleted: event.isCompleted);
    await _tasksRepository.saveTasks(newTask);
  }

  Future<void> _onTasksDeleted(
    TasksDeleted event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTask: () => event.task));
    await _tasksRepository.deleteTasks(event.task.id);
  }

  Future<void> _onUndoDeletion(
    TasksUndoDeletion event,
    Emitter<TasksState> emit,
  ) async {
    assert(
      state.lastDeletedTask != null,
      'No more tasks to delete',
    );

    final task = state.lastDeletedTask!;
    emit(state.copyWith(lastDeletedTask: () => null));
    await _tasksRepository.saveTasks(task);
  }

  void _onFilter(
    TasksFilter event,
    Emitter<TasksState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  void _onCategory(
    CategoriesFilter event,
    Emitter<TasksState> emit,
  ) {
    emit(state.copyWith(category: () => event.category));
  }

  Future<void> _onClearCompleted(
    TasksClearCompleted event,
    Emitter<TasksState> emit,
  ) async {
    await _tasksRepository.clearCompleted();
  }
}
