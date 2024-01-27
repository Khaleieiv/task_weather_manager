import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_weather_manager/home/presentation/pages/home_page.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/utils/tasks_preferences.dart';

// The main function initializes the app and runs it.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of TasksPreferences using SharedPreferences.
  final tasksApi = TasksPreferences(
    plugin: await SharedPreferences.getInstance(),
  );

  // Create an instance of OverviewTasksRepository with TasksPreferences.
  final tasksRepository = OverviewTasksRepository(tasksRepository: tasksApi);

  // Run the app with the specified tasks repository.
  runApp(
    Main(
      tasksRepository: tasksRepository,
    ),
  );
}

// Main is a StatelessWidget that sets up the application structure.
class Main extends StatelessWidget {
  final OverviewTasksRepository tasksRepository;

  const Main({
    required this.tasksRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the OverviewTasksRepository to the entire app.
        RepositoryProvider<OverviewTasksRepository>.value(
          value: tasksRepository,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
