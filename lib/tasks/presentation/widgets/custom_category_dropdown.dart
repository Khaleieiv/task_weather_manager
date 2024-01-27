import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

// CustomCategoryDropdown is a dropdown button for selecting task categories.
class CustomCategoryDropdown extends StatelessWidget {
  const CustomCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current state from the EditTasksBloc.
    final state = context.watch<EditTasksBloc>().state;

    // Get the initially selected category from the task data,
    // or an empty string.
    final selectedCategory = state.initialTasks?.category ?? '';

    // List of available task categories.
    final List<String> categories = ['Work', 'Personal', 'Study', 'Other'];

    // Ensure that categories are unique.
    assert(
    categories.toSet().length == categories.length,
    'Categories must be unique',
    );

    // Ensure the initially selected category is valid;
    // otherwise, use the first category.
    final validSelectedCategory = categories.contains(selectedCategory)
        ? selectedCategory
        : categories.first;

    return Scrollbar(
      child: SingleChildScrollView(
        child: DropdownButton<String>(
          // Current selected category.
          value: validSelectedCategory,

          // Callback when a category is selected.
          onChanged: (value) {
            context.read<EditTasksBloc>().add(EditTasksCategory(value ?? ''));
          },

          // Dropdown menu items.
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),

          // Hint text displayed when no category is selected.
          hint: const Text("Select Category"),
        ),
      ),
    );
  }
}
