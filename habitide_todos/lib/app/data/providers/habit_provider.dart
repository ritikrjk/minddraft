import 'dart:convert';
import 'package:habitide_todos/app/data/models/habit_model.dart';
import 'package:habitide_todos/app/data/providers/database_helper.dart';

class HabitProvider {
  final DatabaseHelper _dbHelper;

  HabitProvider(this._dbHelper);

  Future<int> insertHabit(Habit habit) async {
    final Map<String, dynamic> data = habit.toMap();
    data['completedDates'] = jsonEncode(data['completedDates']); // Encode list to JSON string
    return await _dbHelper.insert('habits', data);
  }

  Future<List<Habit>> getHabits() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query('habits');
    return List.generate(maps.length, (i) {
      final Map<String, dynamic> map = maps[i];
      map['completedDates'] = jsonDecode(map['completedDates']); // Decode JSON string to list
      return Habit.fromMap(map);
    });
  }

  Future<int> updateHabit(Habit habit) async {
    final Map<String, dynamic> data = habit.toMap();
    data['completedDates'] = jsonEncode(data['completedDates']); // Encode list to JSON string
    return await _dbHelper.update(
      'habits',
      data,
      'id = ?',
      [habit.id],
    );
  }

  Future<int> deleteHabit(String id) async {
    return await _dbHelper.delete(
      'habits',
      'id = ?',
      [id],
    );
  }
}
