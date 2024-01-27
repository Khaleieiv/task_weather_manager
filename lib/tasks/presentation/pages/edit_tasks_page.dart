import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';
import 'package:task_weather_manager/tasks/presentation/state/edit_tasks_bloc/edit_tasks_bloc.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/custom_category_dropdown.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/custom_description_field.dart';
import 'package:task_weather_manager/tasks/presentation/widgets/custom_title_field.dart';

class EditTasksPage extends StatelessWidget {
  const EditTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTasksBloc, EditTasksState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTasksStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTasksView(),
    );
  }

  static Route<void> route({TasksData? initialTasks}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTasksBloc(
          tasksRepository: context.read<OverviewTasksRepository>(),
          initialTasks: initialTasks,
        ),
        child: const EditTasksPage(),
      ),
    );
  }
}

class EditTasksView extends StatelessWidget {
  const EditTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditTasksBloc bloc) => bloc.state.status);
    final isNewTasks = context.select(
      (EditTasksBloc bloc) => bloc.state.isNewTasks,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTasks ? "Add Tasks" : "Edit Tasks",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Save changes",
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () =>
                context.read<EditTasksBloc>().add(const EditTasksSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CircularProgressIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: const Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTitleField(),
                CustomDescriptionField(),
                CustomCategoryDropdown(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
