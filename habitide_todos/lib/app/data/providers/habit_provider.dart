import 'package:habitide_todos/app/data/models/habit_model.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';

class HabitProvider {
  final SQLiteStorageService _dbHelper;

  HabitProvider(this._dbHelper);

  Future<void> insertHabit(Habit habit) async {
    await _dbHelper.create<Habit>(habit);
  }

  Future<List<Habit>> getHabits() async {
    return await _dbHelper.readAll<Habit>();
  }

  Future<void> updateHabit(Habit habit) async {
    await _dbHelper.update<Habit>(habit);
  }

  Future<void> deleteHabit(String id) async {
    await _dbHelper.delete<Habit>(id);
  }
}
