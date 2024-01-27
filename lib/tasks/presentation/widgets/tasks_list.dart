import 'package:flutter/material.dart';
import 'package:task_weather_manager/tasks/domain/entities/tasks/tasks_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    required this.task,
    super.key,
    this.afterSwitchingDone,
    this.onDismissed,
    this.onTap,
  });

  final TasksData task;
  final ValueChanged<bool>? afterSwitchingDone;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final key = Key('task_list_${task.id}_dismissible');

    return Dismissible(
      key: key,
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.grey,
        ),
      ),
      child: Column(
        children: [
          Text(
            task.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: !task.isCompleted
                ? null
                : const TextStyle(
              color: Colors.indigoAccent,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          ListTile(
            onTap: onTap,
            title: Text(
              task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: !task.isCompleted
                  ? null
                  : const TextStyle(
                color: Colors.indigoAccent,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text(
              task.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Checkbox(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              value: task.isCompleted,
              onChanged: afterSwitchingDone == null
                  ? null
                  : (value) => afterSwitchingDone!(value!),
            ),
            trailing: onTap == null ? null : const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
