import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_cubit.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_state.dart';
import 'package:task_weather_manager/home/presentation/widgets/home_button.dart';
import 'package:task_weather_manager/tasks/presentation/pages/edit_tasks_page.dart';
import 'package:task_weather_manager/tasks/presentation/pages/tasks_page.dart';
import 'package:task_weather_manager/weather/presentation/pages/weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children:  [TasksPage(), WeatherPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.of(context).push(EditTasksPage.route()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeButton(
              groupValue: selectedTab,
              value: HomeTab.todos,
              icon: const Icon(Icons.list_rounded),
            ),
            HomeButton(
              groupValue: selectedTab,
              value: HomeTab.stats,
              icon: const Icon(Icons.sunny_snowing),
            ),
          ],
        ),
      ),
    );
  }
}
