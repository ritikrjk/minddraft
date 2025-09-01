// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  category: json['category'] as String,
  isCompletedToday: const BoolIntConverter().fromJson(
    (json['isCompletedToday'] as num).toInt(),
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastCompletedAt: json['lastCompletedAt'] == null
      ? null
      : DateTime.parse(json['lastCompletedAt'] as String),
  streakCount: (json['streakCount'] as num).toInt(),
  completedDates: (json['completedDates'] as List<dynamic>)
      .map((e) => DateTime.parse(e as String))
      .toList(),
);

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'isCompletedToday': const BoolIntConverter().toJson(
    instance.isCompletedToday,
  ),
  'createdAt': instance.createdAt.toIso8601String(),
  'lastCompletedAt': instance.lastCompletedAt?.toIso8601String(),
  'streakCount': instance.streakCount,
  'completedDates': instance.completedDates
      .map((e) => e.toIso8601String())
      .toList(),
};
