import 'package:flutter/material.dart';

class PlannerActivity {
  final String id;
  String title;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime date;
  DateTime createdAt;
  bool isCompleted;

  PlannerActivity({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    DateTime? date,
    DateTime? createdAt,
    this.isCompleted = false,
  }) : 
    date = date ?? DateTime.now(),
    createdAt = createdAt ?? DateTime.now();

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory PlannerActivity.fromMap(Map<String, dynamic> map) {
    final startTimeParts = map['startTime'].split(':');
    final endTimeParts = map['endTime'].split(':');
    
    return PlannerActivity(
      id: map['id'],
      title: map['title'],
      startTime: TimeOfDay(
        hour: int.parse(startTimeParts[0]), 
        minute: int.parse(startTimeParts[1])
      ),
      endTime: TimeOfDay(
        hour: int.parse(endTimeParts[0]), 
        minute: int.parse(endTimeParts[1])
      ),
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['createdAt']),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
