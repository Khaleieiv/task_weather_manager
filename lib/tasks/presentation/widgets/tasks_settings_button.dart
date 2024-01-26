import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';

class TasksSettingButton extends StatelessWidget {
  const TasksSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TasksBloc bloc) => bloc.state.tasks);
    final hasTodos = tasks.isNotEmpty;
    final completedTodosAmount = tasks.where((todo) => todo.isCompleted).length;

    return PopupMenuButton(
      tooltip: "Setting",
      icon: const Icon(
        Icons.edit_rounded,
        color: Colors.white,
      ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (options) =>
          context.read<TasksBloc>().add(const TasksClearCompleted()),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            enabled: hasTodos && completedTodosAmount > 0,
            child: const Text("Clear completed"),
          ),
        ];
      },
    );
  }
}
