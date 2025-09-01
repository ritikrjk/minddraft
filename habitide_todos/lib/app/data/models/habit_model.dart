// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert'; // Added import

import 'package:json_annotation/json_annotation.dart';

part 'habit_model.g.dart';

// Custom JsonConverter for bool to int (and vice-versa)
class BoolIntConverter implements JsonConverter<bool, int> {
  const BoolIntConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

@JsonSerializable()
class Habit {
  final String id;
  String title;
  String? description;
  String category;
  @BoolIntConverter() // Apply converter
  bool isCompletedToday;
  DateTime createdAt;
  DateTime? lastCompletedAt;
  int streakCount;
  List<DateTime> completedDates;
  Habit({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    required this.isCompletedToday,
    required this.createdAt,
    this.lastCompletedAt,
    required this.streakCount,
    required this.completedDates,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isCompletedToday,
    DateTime? createdAt,
    DateTime? lastCompletedAt,
    int? streakCount,
    List<DateTime>? completedDates,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      createdAt: createdAt ?? this.createdAt,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      streakCount: streakCount ?? this.streakCount,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  factory Habit.fromMap(Map<String, dynamic> json) {
    final Map<String, dynamic> newJson = Map.from(json); // Create a mutable copy

    // Handle completedDates: stored as String in DB, needs to be List<DateTime>
    if (newJson['completedDates'] is String && newJson['completedDates'] != null) {
      try {
        newJson['completedDates'] = (jsonDecode(newJson['completedDates']) as List)
            .map((e) => e.toString()) // Ensure elements are strings before parsing to DateTime
            .toList();
      } catch (e) {
        print('Error decoding completedDates: $e'); // Keep print for now, will remove later
        newJson['completedDates'] = []; // Default to empty list on error
      }
    } else if (newJson['completedDates'] == null) {
      newJson['completedDates'] = []; // Default to empty list if null
    }

    return _$HabitFromJson(newJson);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = _$HabitToJson(this);
    map['completedDates'] = jsonEncode(map['completedDates']); // Encode the list to a JSON string
    return map;
  }
}
