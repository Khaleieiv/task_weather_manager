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

// TasksPage is the main page for displaying and managing tasks.
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider for managing state using TasksBloc and
    // initiating subscription.
    return BlocProvider(
      create: (context) => TasksBloc(
        tasksRepository: context.read<OverviewTasksRepository>(),
      )..add(const TasksSubscription()),
      child: const TasksView(),
    );
  }
}

// TasksView represents the UI for displaying and managing tasks.
class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold containing the app bar and tasks list.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tasks Weather Manager",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
        // App bar actions include buttons for category filter,
        // tasks filter, and tasks settings.
        actions: const [
          CategoryFilterButton(),
          TasksFilterButton(),
          TasksSettingButton(),
        ],
      ),
      // Body of the page, containing a MultiBlocListener for
      // handling various state changes.
      body: MultiBlocListener(
        listeners: [
          // Listener for displaying an error message if tasks loading fails.
          BlocListener<TasksBloc, TasksState>(
            listenWhen: (previous, current) =>
            previous.status != current.status,
            listener: (context, state) {
              if (state.status == TasksStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("An error occurred while loading tasks."),
                    ),
                  );
              }
            },
          ),
          // Listener for displaying a snackbar when a task is deleted.
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
                    content: const Text("Task deleted"),
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
        // Child of MultiBlocListener is a BlocBuilder for handling tasks
        // state and displaying the tasks list.
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            // Handling different scenarios based on tasks state.
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

            // Displaying the tasks list using a Scrollbar and ListView.
            return Scrollbar(
              child: ListView(
                children: [
                  // Creating TasksList widget for each task,
                  // applying category filter.
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
