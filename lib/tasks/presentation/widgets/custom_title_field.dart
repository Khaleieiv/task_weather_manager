import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

// CustomTitleField is a text form field for entering task titles.
class CustomTitleField extends StatelessWidget {
  const CustomTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    // Constants for maximum length of the title and a regular
    // expression to allow specific characters.
    const maxLength = 50;
    final regExp = RegExp(r'[a-zA-Z0-9\s]');

    // Retrieve the current state from the EditTasksBloc.
    final state = context.watch<EditTasksBloc>().state;

    // Initial hint text from the task data.
    final hintText = state.initialTasks?.title ?? '';

    return TextFormField(
      // Initial value of the title field.
      initialValue: state.title,

      // Decoration for the text form field.
      decoration: InputDecoration(
        // Enable or disable the field based on the loading status.
        enabled: !state.status.isLoadingOrSuccess,

        // Label text displayed above the field.
        labelText: "Title",

        // Hint text displayed inside the field.
        hintText: hintText,
      ),

      // Maximum length of the input.
      maxLength: maxLength,

      // Input formatters to limit the length and
      // allow specific characters in the input.
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.allow(regExp),
      ],

      // Callback when the content of the field changes.
      onChanged: (value) {
        context.read<EditTasksBloc>().add(EditTasksTitle(value));
      },
    );
  }
}
