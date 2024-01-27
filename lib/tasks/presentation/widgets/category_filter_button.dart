import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';
import 'package:task_weather_manager/tasks/utils/category_filter.dart';

class CategoryFilterButton extends StatelessWidget {
  const CategoryFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeCategory =
        context.select((TasksBloc bloc) => bloc.state.category);

    return PopupMenuButton<CategoryFilter>(
      tooltip: "Filter by Category",
      icon: const Icon(
        Icons.category,
        color: Colors.white,
      ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeCategory,
      onSelected: (category) {
        context.read<TasksBloc>().add(CategoriesFilter(category));
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: CategoryFilter.all, // Empty string for showing all categories
            child: Text("All Categories"),
          ),
          const PopupMenuItem(
            value: CategoryFilter.work,
            child: Text("Work"),
          ),
          const PopupMenuItem(
            value: CategoryFilter.personal,
            child: Text("Personal"),
          ),
          const PopupMenuItem(
            value: CategoryFilter.study,
            child: Text("Study"),
          ),
          const PopupMenuItem(
            value: CategoryFilter.other,
            child: Text("Other"),
          ),
        ];
      },
    );
  }
}
