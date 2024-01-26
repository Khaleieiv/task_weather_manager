import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    const maxLength = 300;
    const maxLines = 7;

    final state = context.watch<EditTasksBloc>().state;
    final hintText = state.initialTasks?.description ?? '';

    return TextFormField(
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: "Description",
        hintText: hintText,
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: (value) {
        context.read<EditTasksBloc>().add(EditTasksDescription(value));
      },
    );
  }
}
