import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_weather_manager/home/presentation/pages/home_page.dart';
import 'package:task_weather_manager/tasks/data/repositories/overview_tasks_repository.dart';
import 'package:task_weather_manager/tasks/utils/tasks_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tasksApi = TasksPreferences(
    plugin: await SharedPreferences.getInstance(),
  );
  final todosRepository = OverviewTasksRepository(tasksRepository: tasksApi);

  runApp(
    Main(
      tasksRepository: todosRepository,
    ),
  );
}

class Main extends StatelessWidget {
  final OverviewTasksRepository tasksRepository;

  const Main({required this.tasksRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
