import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

enum CategoryFilter { all, work, personal, study, other }

extension CategoryFilterCustom on CategoryFilter {
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

  Iterable<TasksData> applyAll(Iterable<TasksData> tasks) {
    return tasks.where(apply);
  }
}
