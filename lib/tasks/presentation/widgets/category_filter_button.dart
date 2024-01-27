import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/tasks_bloc/tasks_bloc.dart';
import 'package:task_weather_manager/tasks/utils/category_filter.dart';

// CategoryFilterButton is a button that allows users
// to filter tasks by category.
class CategoryFilterButton extends StatelessWidget {
  const CategoryFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the active category from the TasksBloc state.
    final activeCategory =
    context.select((TasksBloc bloc) => bloc.state.category);

    return PopupMenuButton<CategoryFilter>(
      // Tooltip for the button.
      tooltip: "Filter by Category",

      // Icon for the button.
      icon: const Icon(
        Icons.category,
        color: Colors.white,
      ),

      // Shape of the popup menu.
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      // Initial value selected in the popup menu.
      initialValue: activeCategory,

      // Callback when a category is selected.
      onSelected: (category) {
        context.read<TasksBloc>().add(CategoriesFilter(category));
      },

      // Popup menu items.
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: CategoryFilter.all,
            // Empty string for showing all categories.
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
