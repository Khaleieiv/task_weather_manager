import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

// CategoryFilter represents different categories for filtering tasks.
enum CategoryFilter { all, work, personal, study, other }

// CategoryFilterCustom extension provides methods to apply category filtering on tasks.
extension CategoryFilterCustom on CategoryFilter {
  // Apply the category filter to a specific task.
  bool apply(TasksData task) {
    switch (this) {
      case CategoryFilter.all:
        return true;
      case CategoryFilter.work:
        return task.category == 'Work';
      case CategoryFilter.personal:
        return task.category == 'Personal';
      case CategoryFilter.study:
        return task.category == 'Study';
      case CategoryFilter.other:
        return task.category == 'Other';
    }
  }

  // Apply the category filter to a collection of tasks.
  Iterable<TasksData> applyAll(Iterable<TasksData> tasks) {
    return tasks.where(apply);
  }
}
