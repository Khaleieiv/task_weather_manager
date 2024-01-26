import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';
import 'package:task_weather_manager/tasks/utils/task_filter.dart';

class TasksFilterButton extends StatelessWidget {
  const TasksFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter = context.select((TasksBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TaskFilter>(
      tooltip: "Filter",
      icon: const Icon(
        Icons.filter_alt_rounded,
        color: Colors.white,
      ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      onSelected: (filter) {
        context.read<TasksBloc>().add(TasksFilter(filter));
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: TaskFilter.all,
            child: Text("All"),
          ),
          const PopupMenuItem(
            value: TaskFilter.activeOnly,
            child: Text("ActiveOnly"),
          ),
          const PopupMenuItem(
            value: TaskFilter.completedOnly,
            child: Text("CompletedOnly"),
          ),
        ];
      },
    );
  }
}
