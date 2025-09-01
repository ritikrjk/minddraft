import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'todo_model.g.dart';

// Custom JsonConverter for bool to int (and vice-versa)
class BoolIntConverter implements JsonConverter<bool, int> {
  const BoolIntConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

@JsonSerializable()
class Todo {
  final String id;
  String title;
  String? description;
  String priority;
  String category;
  List<String>? subtasks;
  @BoolIntConverter() // Apply converter
  bool isDone;
  DateTime createdAt;
  DateTime? completedAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.category,
    this.subtasks,
    required this.isDone,
    required this.createdAt,
    this.completedAt,
  });
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? category,
    List<String>? subtasks,
    bool? isDone,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      subtasks: subtasks ?? this.subtasks,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory Todo.fromMap(Map<String, dynamic> json) {
    // Handle subtasks: stored as String in DB, needs to be List<String>
    if (json['subtasks'] is String && json['subtasks'] != null) {
      try {
        json['subtasks'] = (jsonDecode(json['subtasks']) as List)
            .map((e) => e.toString())
            .toList();
      } catch (e) {
        print('Error decoding subtasks: $e'); // Keep print for now, will remove later
        json['subtasks'] = [];
      }
    } else if (json['subtasks'] == null) {
      json['subtasks'] = [];
    }
    return _$TodoFromJson(json);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = _$TodoToJson(this);
    if (map['subtasks'] != null) {
      map['subtasks'] = jsonEncode(map['subtasks']); // Encode the list to a JSON string
    }
    return map;
  }
}
