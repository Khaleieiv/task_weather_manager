import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';

class CustomTitleField extends StatelessWidget {
  const CustomTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    const maxLength = 50;
    final regExp = RegExp(r'[a-zA-Z0-9\s]');

    final state = context.watch<EditTasksBloc>().state;
    final hintText = state.initialTasks?.title ?? '';

    return TextFormField(
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: "Title",
        hintText: hintText,
      ),
      maxLength: maxLength,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.allow(regExp),
      ],
      onChanged: (value) {
        context.read<EditTasksBloc>().add(EditTasksTitle(value));
      },
    );
  }
}
