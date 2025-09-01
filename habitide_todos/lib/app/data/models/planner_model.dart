// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'planner_model.g.dart'; // Corrected part directive

// Custom JsonConverter for bool to int (and vice-versa)
class BoolIntConverter implements JsonConverter<bool, int> {
  const BoolIntConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

// Custom JsonConverter for TimeOfDay
class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour.toString().padLeft(2, '0')}:${object.minute.toString().padLeft(2, '0')}';
  }
}

@JsonSerializable()
class PlannerActivity {
  final String id;
  String title;
  @TimeOfDayConverter() // Apply converter
  TimeOfDay startTime;
  @TimeOfDayConverter() // Apply converter
  TimeOfDay endTime;
  DateTime date;
  DateTime createdAt;
  @BoolIntConverter() // Apply converter
  bool isCompleted;

  PlannerActivity({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.createdAt,
    required this.isCompleted,
  }); 

  PlannerActivity copyWith({
    String? id,
    String? title,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? date,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return PlannerActivity(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory PlannerActivity.fromMap(Map<String, dynamic> json) {
    return _$PlannerActivityFromJson(json);
  }
  Map<String, dynamic> toMap() => _$PlannerActivityToJson(this);
}
