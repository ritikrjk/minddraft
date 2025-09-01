// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority: json['priority'] as String,
  category: json['category'] as String,
  subtasks: (json['subtasks'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isDone: const BoolIntConverter().fromJson((json['isDone'] as num).toInt()),
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'priority': instance.priority,
  'category': instance.category,
  'subtasks': instance.subtasks,
  'isDone': const BoolIntConverter().toJson(instance.isDone),
  'createdAt': instance.createdAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
};
