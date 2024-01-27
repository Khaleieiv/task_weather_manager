import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';

// TasksOption represents available options for task settings.
enum TasksOption { clearCompleted }

// TasksSettingButton is a widget providing settings options for the task list.
class TasksSettingButton extends StatelessWidget {
  const TasksSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Selecting the current state of tasks from the TasksBloc.
    final tasks = context.select((TasksBloc bloc) => bloc.state.tasks);

    // Determine if there are any tasks and the number of completed tasks.
    final hasTodos = tasks.isNotEmpty;
    final completedTodosAmount = tasks.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TasksOption>(
      tooltip: "Setting",
      // Icon for the settings button.
      icon: const Icon(
        Icons.edit_rounded,
        color: Colors.white,
      ),
      // Styling for the popup menu.
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      // Handling the selected option.
      onSelected: (options) =>
          context.read<TasksBloc>().add(const TasksClearCompleted()),
      // Popup menu items with available options.
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            // Option to clear completed tasks.
            value: TasksOption.clearCompleted,
            // Enabled only if there are tasks and some are completed.
            enabled: hasTodos && completedTodosAmount > 0,
            child: const Text("Clear completed"),
          ),
        ];
      },
    );
  }
}
