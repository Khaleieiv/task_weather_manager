import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

class CustomCategoryDropdown extends StatelessWidget {
  const CustomCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTasksBloc>().state;
    final selectedCategory = state.initialTasks?.category ?? '';

    final List<String> categories = ['Work', 'Personal', 'Study', 'Other'];

    assert(
      categories.toSet().length == categories.length,
      'Categories must be unique',
    );

    final validSelectedCategory = categories.contains(selectedCategory)
        ? selectedCategory
        : categories.first;

    return Scrollbar(
      child: SingleChildScrollView(
        child: DropdownButton<String>(
          value: validSelectedCategory,
          onChanged: (value) {
            context.read<EditTasksBloc>().add(EditTasksCategory(value ?? ''));
          },
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          hint: const Text("Select Category"),
        ),
      ),
    );
  }
}
