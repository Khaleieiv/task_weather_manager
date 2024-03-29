import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_cubit.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_state.dart';
import 'package:task_weather_manager/home/presentation/widgets/home_button.dart';
import 'package:task_weather_manager/tasks/presentation/pages/edit_tasks_page.dart';
import 'package:task_weather_manager/tasks/presentation/pages/tasks_page.dart';
import 'package:task_weather_manager/weather/presentation/pages/weather_page.dart';

// HomePage is the main entry point for the application,
// providing a scaffold for the entire UI.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a BlocProvider for managing the state using HomeCubit.
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

// HomeView represents the UI of the home screen,
// including the bottom navigation and content.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the selected tab from the HomeCubit state.
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      // Use IndexedStack to switch between different content
      // based on the selected tab.
      body: IndexedStack(
        index: selectedTab.index,
        children: [const TasksPage(), WeatherPage()],
      ),
      // Configure the floating action button for adding tasks.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.of(context).push(EditTasksPage.route()),
        child: const Icon(Icons.add),
      ),
      // Configure the bottom navigation bar using a
      // custom HomeButton for each tab.
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
