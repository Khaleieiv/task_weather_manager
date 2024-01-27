import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_weather_manager/home/presentation/cubit/home_state.dart';

// HomeCubit is a BLoC (Business Logic Component)
// managing the state for the home screen.
class HomeCubit extends Cubit<HomeState> {
  // Constructor initializes the HomeCubit with the initial state.
  HomeCubit() : super(const HomeState());

  // Method to set the selected tab and emit a new state.
  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}
