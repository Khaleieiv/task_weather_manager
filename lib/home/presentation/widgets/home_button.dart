import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_cubit.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_state.dart';

// Custom button for tab navigation in the home screen.
class HomeButton extends StatelessWidget {
  // The currently selected tab value in the group.
  final HomeTab groupValue;

  // The value associated with this button.
  final HomeTab value;

  // The icon to be displayed on the button.
  final Widget icon;

  // Constructor for the HomeButton class.
  const HomeButton({
    required this.groupValue,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Callback to update the selected tab when the button is pressed.
    void updateSelectedTab() {
      context.read<HomeCubit>().setTab(value);
    }

    // Constant for the size of the icon.
    const iconSize = 24.0;

    return IconButton(
      onPressed: updateSelectedTab,
      iconSize: iconSize,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
