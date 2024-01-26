import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'tasks_data.g.dart';

typedef JsonMap = Map<String, dynamic>;

@JsonSerializable()
class TasksData extends Equatable {
  final String id;

  final String title;

  final String description;

  final bool isCompleted;

  TasksData({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  TasksData copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TasksData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static TasksData fromJson(JsonMap json) => _$TasksDataFromJson(json);

  JsonMap toJson() => _$TasksDataToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, isCompleted];
}
