import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/presentation/pages/edit_tasks_page.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/category_filter_button.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/tasks_filter_button.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/tasks_list.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/tasks_settings_button.dart';
import 'package:task_weather_manager/tasks/utils/category_filter.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(
        tasksRepository: context.read<OverviewTasksRepository>(),
      )..add(const TasksSubscription()),
      child: const TasksView(),
    );
  }
}

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tasks Weather Manager",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
        actions: const [
          CategoryFilterButton(),
          TasksFilterButton(),
          TasksSettingButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TasksBloc, TasksState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TasksStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("An error occurred while uploading tasks."),
                    ),
                  );
              }
            },
          ),
          BlocListener<TasksBloc, TasksState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTask != current.lastDeletedTask &&
                current.lastDeletedTask != null,
            listener: (context, state) {
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Task deleted",
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TasksBloc>()
                            .add(const TasksUndoDeletion());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state.tasks.isEmpty) {
              if (state.status == TasksStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != TasksStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    "No tasks found with the selected filters",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return Scrollbar(
              child: ListView(
                children: [
                  for (final task in state.filteredTodos)
                    if (state.category.apply(task))
                    TasksList(
                      task: task,
                      afterSwitchingDone: (isCompleted) {
                        context.read<TasksBloc>().add(
                          TasksCompletion(
                            task: task,
                            isCompleted: isCompleted,
                          ),
                        );
                      },
                      onDismissed: (_) {
                        context.read<TasksBloc>().add(TasksDeleted(task));
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          EditTasksPage.route(initialTasks: task),
                        );
                      },
                    ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
