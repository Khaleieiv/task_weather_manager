import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

// TaskFilter is an enumeration representing different filters for tasks.
enum TaskFilter { all, activeOnly, completedOnly }

// Extension on TaskFilter providing methods to apply the
// filter on a collection of tasks.
extension TasksFilterCustom on TaskFilter {
  // apply method checks if a task satisfies the filter
  // condition based on the filter type.
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

  // applyAll method filters a collection of tasks
  // based on the current filter type.
  Iterable<TasksData> applyAll(Iterable<TasksData> tasks) {
    return tasks.where(apply);
  }
}
