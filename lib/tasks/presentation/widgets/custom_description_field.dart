import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

// CustomDescriptionField is a text form field for entering task descriptions.
class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    // Constants for maximum length and lines in the description field.
    const maxLength = 300;
    const maxLines = 7;

    // Retrieve the current state from the EditTasksBloc.
    final state = context.watch<EditTasksBloc>().state;

    // Initial hint text from the task data.
    final hintText = state.initialTasks?.description ?? '';

    return TextFormField(
      // Initial value of the description field.
      initialValue: state.description,

      // Decoration for the text form field.
      decoration: InputDecoration(
        // Enable or disable the field based on the loading status.
        enabled: !state.status.isLoadingOrSuccess,

        // Label text displayed above the field.
        labelText: "Description",

        // Hint text displayed inside the field.
        hintText: hintText,
      ),

      // Maximum length of the input.
      maxLength: maxLength,

      // Maximum lines to display in the description field.
      maxLines: maxLines,

      // Input formatters to limit the length of the input.
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],

      // Callback when the content of the field changes.
      onChanged: (value) {
        context.read<EditTasksBloc>().add(EditTasksDescription(value));
      },
    );
  }
}
