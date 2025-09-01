
import 'package:habitide_todos/app/data/models/habit_model.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';

class HabitProvider {
  final SQLiteStorageService _dbHelper;

  HabitProvider(this._dbHelper);

  Future<void> insertHabit(Habit habit) async {
    return await _dbHelper.addHabit(habit);
  }

  Future<List<Habit>> getHabits() async {
    return await _dbHelper.getHabits();
  }

  Future<void> updateHabit(Habit habit) async {
    return await _dbHelper.updateHabit(habit);
  }

  Future<void> deleteHabit(String id) async {
    return await _dbHelper.deleteHabit(id);
  }
}