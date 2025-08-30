import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/habit_model.dart';
import '../models/note_model.dart';
import '../models/planner_model.dart';
import '../models/todo_model.dart';

class LocalStorageService {
  static const String _todosKey = 'todos';
  static const String _habitsKey = 'habits';
  static const String _notesKey = 'notes';
  static const String _plannerActivitiesKey = 'planner_activities';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode({'title': todo.title, 'isDone': todo.isDone})).toList();
    await prefs.setStringList(_todosKey, todosJson);
  }

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList(_todosKey) ?? [];
    return todosJson.map((todoJson) {
      final todoMap = jsonDecode(todoJson);
      return Todo(title: todoMap['title'], isDone: todoMap['isDone']);
    }).toList();
  }

  Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = habits.map((habit) => jsonEncode({'title': habit.title, 'isCompletedToday': habit.isCompletedToday})).toList();
    await prefs.setStringList(_habitsKey, habitsJson);
  }

  Future<List<Habit>> getHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = prefs.getStringList(_habitsKey) ?? [];
    return habitsJson.map((habitJson) {
      final habitMap = jsonDecode(habitJson);
      return Habit(title: habitMap['title'], isCompletedToday: habitMap['isCompletedToday']);
    }).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = notes.map((note) => jsonEncode({'title': note.title, 'content': note.content})).toList();
    await prefs.setStringList(_notesKey, notesJson);
  }

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList(_notesKey) ?? [];
    return notesJson.map((noteJson) {
      final noteMap = jsonDecode(noteJson);
      return Note(title: noteMap['title'], content: noteMap['content']);
    }).toList();
  }

  Future<void> savePlannerActivities(List<PlannerActivity> activities) async {
    final prefs = await SharedPreferences.getInstance();
    final activitiesJson = activities.map((activity) => jsonEncode({
      'title': activity.title,
      'startTime': '${activity.startTime.hour}:${activity.startTime.minute}',
      'endTime': '${activity.endTime.hour}:${activity.endTime.minute}',
    })).toList();
    await prefs.setStringList(_plannerActivitiesKey, activitiesJson);
  }

  Future<List<PlannerActivity>> getPlannerActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final activitiesJson = prefs.getStringList(_plannerActivitiesKey) ?? [];
    return activitiesJson.map((activityJson) {
      final activityMap = jsonDecode(activityJson);
      final startTimeParts = activityMap['startTime'].split(':');
      final endTimeParts = activityMap['endTime'].split(':');
      return PlannerActivity(
        title: activityMap['title'],
        startTime: TimeOfDay(hour: int.parse(startTimeParts[0]), minute: int.parse(startTimeParts[1])),
        endTime: TimeOfDay(hour: int.parse(endTimeParts[0]), minute: int.parse(endTimeParts[1])),
      );
    }).toList();
  }
}
