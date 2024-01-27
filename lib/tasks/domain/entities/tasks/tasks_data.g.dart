// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksData _$TasksDataFromJson(Map<String, dynamic> json) => TasksData(
      title: json['title'] as String,
      category: json['category'] as String? ?? "",
      id: json['id'] as String?,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TasksDataToJson(TasksData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'category': instance.category,
    };
