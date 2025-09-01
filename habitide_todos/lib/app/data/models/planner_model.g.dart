// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlannerActivity _$PlannerActivityFromJson(Map<String, dynamic> json) =>
    PlannerActivity(
      id: json['id'] as String,
      title: json['title'] as String,
      startTime: const TimeOfDayConverter().fromJson(
        json['startTime'] as String,
      ),
      endTime: const TimeOfDayConverter().fromJson(json['endTime'] as String),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: const BoolIntConverter().fromJson(
        (json['isCompleted'] as num).toInt(),
      ),
    );

Map<String, dynamic> _$PlannerActivityToJson(PlannerActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startTime': const TimeOfDayConverter().toJson(instance.startTime),
      'endTime': const TimeOfDayConverter().toJson(instance.endTime),
      'date': instance.date.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'isCompleted': const BoolIntConverter().toJson(instance.isCompleted),
    };
