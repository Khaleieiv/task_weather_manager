import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';
import 'package:task_weather_manager/tasks/utils/task_filter.dart';

// TasksFilterButton is a button for selecting task filters.
class TasksFilterButton extends StatelessWidget {
  const TasksFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current active filter from the TasksBloc.
    final activeFilter = context.select((TasksBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TaskFilter>(
      // Tooltip for the filter button.
      tooltip: "Filter",

      // Icon for the filter button.
      icon: const Icon(
        Icons.filter_alt_rounded,
        color: Colors.white,
      ),

      // Shape of the filter button.
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      // Initial value of the filter button.
      initialValue: activeFilter,

      // Callback when a filter is selected.
      onSelected: (filter) {
        context.read<TasksBloc>().add(TasksFilter(filter));
      },

      // Items in the filter dropdown menu.
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: TaskFilter.all,
            child: Text("All"),
          ),
          const PopupMenuItem(
            value: TaskFilter.activeOnly,
            child: Text("Active Only"),
          ),
          const PopupMenuItem(
            value: TaskFilter.completedOnly,
            child: Text("Completed Only"),
          ),
        ];
      },
    );
  }
}
