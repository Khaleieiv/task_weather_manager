import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

<<<<<<< HEAD
// CustomCategoryDropdown is a dropdown button for selecting task categories.
=======
>>>>>>> origin/main
class CustomCategoryDropdown extends StatelessWidget {
  const CustomCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    final state = context.watch<EditTasksBloc>().state;
    final selectedCategory = state.initialTasks?.category ?? '';

    final List<String> categories = ['Work', 'Personal', 'Study', 'Other'];

    assert(
      categories.toSet().length == categories.length,
      'Categories must be unique',
    );

>>>>>>> origin/main
    final validSelectedCategory = categories.contains(selectedCategory)
        ? selectedCategory
        : categories.first;

    return Scrollbar(
      child: SingleChildScrollView(
        child: DropdownButton<String>(
<<<<<<< HEAD
          // Current selected category.
          value: validSelectedCategory,

          // Callback when a category is selected.
          onChanged: (value) {
            context.read<EditTasksBloc>().add(EditTasksCategory(value ?? ''));
          },

          // Dropdown menu items.
=======
          value: validSelectedCategory,
          onChanged: (value) {
            context.read<EditTasksBloc>().add(EditTasksCategory(value ?? ''));
          },
>>>>>>> origin/main
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
<<<<<<< HEAD

          // Hint text displayed when no category is selected.
=======
>>>>>>> origin/main
          hint: const Text("Select Category"),
        ),
      ),
    );
  }
}
