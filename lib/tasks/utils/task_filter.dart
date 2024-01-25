import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

enum TaskFilter { all, activeOnly, completedOnly }

extension TasksFilterCustom on TaskFilter {
  bool apply(TasksData task) {
    switch (this) {
      case TaskFilter.all:
        return true;
      case TaskFilter.activeOnly:
        return !task.isCompleted;
      case TaskFilter.completedOnly:
        return task.isCompleted;
    }
  }

  Iterable<TasksData> applyAll(Iterable<TasksData> tasks) {
    return tasks.where(apply);
  }
}
