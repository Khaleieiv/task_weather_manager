import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_cubit.dart';
import 'package:task_weather_manager/home/presentation/cubit/home_state.dart';

class HomeButton extends StatelessWidget {
  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  const HomeButton({
    required this.groupValue,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const iconSize = 24.0;

    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: iconSize,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
