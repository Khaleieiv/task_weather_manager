import 'package:equatable/equatable.dart';

// Enum representing different tabs on the home screen.
enum HomeTab { todos, stats }

// HomeState represents the state for the home screen,
// including the selected tab.
class HomeState extends Equatable {
  // Constructor initializes the HomeState with a default tab.
  const HomeState({
    this.tab = HomeTab.todos,
  });

  // The currently selected tab.
  final HomeTab tab;

  // Override Equatable props to enable state comparison.
  @override
  List<Object> get props => [tab];
}
