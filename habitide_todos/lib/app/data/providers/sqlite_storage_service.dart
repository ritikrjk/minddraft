import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';
import '../models/habit_model.dart';
import '../models/note_model.dart';
import '../models/planner_model.dart';
import 'storage_interface.dart';

class SQLiteStorageService implements StorageInterface {
  static Database? _database;
  static const String _databaseName = 'habitide_todos.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String _todosTable = 'todos';
  static const String _habitsTable = 'habits';
  static const String _habitCompleteTable = 'habit_complete';
  static const String _notesTable = 'notes';
  static const String _plannerTable = 'planner_activities';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create todos table
    await db.execute('''
      CREATE TABLE $_todosTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0,
        createdAt INTEGER NOT NULL,
        completedAt INTEGER
      )
    ''');

    // Create habits table
    await db.execute('''
      CREATE TABLE $_habitsTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        isCompletedToday INTEGER NOT NULL DEFAULT 0,
        createdAt INTEGER NOT NULL,
        lastCompletedAt INTEGER,
        streakCount INTEGER NOT NULL DEFAULT 0,
        completedDates TEXT
      )
    ''');

    await db.execute(''' 
    CREATE TABLE $_habitCompleteTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    habitId TEXT NOT NULL,
    date INTEGER NOT NULL,
   FOREIGN KEY (habitId) REFERENCES habits(id) ON DELETE CASCADE
);
      ''');

    // Create notes table
    await db.execute('''
      CREATE TABLE $_notesTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL
      )
    ''');

    // Create planner activities table
    await db.execute('''
      CREATE TABLE $_plannerTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        startTime INTEGER NOT NULL,
        endTime INTEGER NOT NULL,
        date INTEGER NOT NULL,
        createdAt INTEGER NOT NULL,
        isCompleted INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle future database schema updates
  }

  // Generic CRUD operations
  @override
  Future<T> create<T>(T item) async {
    final db = await database;
    if (item is Habit) {
      await db.insert(_habitsTable, item.toMap());
      return item;
    }
    throw UnimplementedError('Create method not implemented for this type');
  }

  @override
  Future<T?> read<T>(String id) async {
    final db = await database;
    if (T == Habit) {
      final List<Map<String, dynamic>> maps = await db.query(
        _habitsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Habit.fromMap(maps.first) as T;
      }
      return null;
    }
    throw UnimplementedError('Read method not implemented for this type');
  }

  @override
  Future<List<T>> readAll<T>() async {
    final db = await database;
    if (T == Habit) {
      final List<Map<String, dynamic>> maps = await db.query(_habitsTable);
      return List.generate(maps.length, (i) => Habit.fromMap(maps[i])) as List<T>;
    }
    throw UnimplementedError('ReadAll method not implemented for this type');
  }

  @override
  Future<T> update<T>(T item) async {
    final db = await database;
    if (item is Habit) {
      await db.update(
        _habitsTable,
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
      return item;
    }
    throw UnimplementedError('Update method not implemented for this type');
  }

  @override
  Future<bool> delete<T>(String id) async {
    final db = await database;
    if (T == Habit) {
      final rowsDeleted = await db.delete(
        _habitsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      return rowsDeleted > 0;
    }
    throw UnimplementedError('Delete method not implemented for this type');
  }

  // Todo operations
  @override
  Future<List<Todo>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_todosTable);
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(_todosTable);
      for (final todo in todos) {
        await txn.insert(_todosTable, todo.toMap());
      }
    });
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final db = await database;
    await db.insert(_todosTable, todo.toMap());
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      _todosTable,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> deleteTodo(String id) async {
    final db = await database;
    await db.delete(_todosTable, where: 'id = ?', whereArgs: [id]);
  }

  // Habit operations
  @override
  Future<List<Habit>> getHabits() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_habitsTable);
    return List.generate(maps.length, (i) => Habit.fromMap(maps[i]));
  }

  @override
  Future<void> saveHabits(List<Habit> habits) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(_habitsTable);
      for (final habit in habits) {
        await txn.insert(_habitsTable, habit.toMap());
      }
    });
  }

  @override
  Future<void> addHabit(Habit habit) async {
    final db = await database;
    await db.insert(_habitsTable, habit.toMap());
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final db = await database;
    await db.update(
      _habitsTable,
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  @override
  Future<void> deleteHabit(String id) async {
    final db = await database;
    await db.delete(_habitsTable, where: 'id = ?', whereArgs: [id]);
  }

  // Note operations
  @override
  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_notesTable);
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  @override
  Future<void> saveNotes(List<Note> notes) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(_notesTable);
      for (final note in notes) {
        await txn.insert(_notesTable, note.toMap());
      }
    });
  }

  @override
  Future<void> addNote(Note note) async {
    final db = await database;
    await db.insert(_notesTable, note.toMap());
  }

  @override
  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      _notesTable,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete(_notesTable, where: 'id = ?', whereArgs: [id]);
  }

  // Planner operations
  @override
  Future<List<PlannerActivity>> getPlannerActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_plannerTable);
    return List.generate(maps.length, (i) => PlannerActivity.fromMap(maps[i]));
  }

  @override
  Future<void> savePlannerActivities(List<PlannerActivity> activities) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(_plannerTable);
      for (final activity in activities) {
        await txn.insert(_plannerTable, activity.toMap());
      }
    });
  }

  @override
  Future<void> addPlannerActivity(PlannerActivity activity) async {
    final db = await database;
    await db.insert(_plannerTable, activity.toMap());
  }

  @override
  Future<void> updatePlannerActivity(PlannerActivity activity) async {
    final db = await database;
    await db.update(
      _plannerTable,
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  @override
  Future<void> deletePlannerActivity(String id) async {
    final db = await database;
    await db.delete(_plannerTable, where: 'id = ?', whereArgs: [id]);
  }

  // Additional useful methods
  Future<List<PlannerActivity>> getPlannerActivitiesByDate(
    DateTime date,
  ) async {
    final db = await database;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final List<Map<String, dynamic>> maps = await db.query(
      _plannerTable,
      where: 'date >= ? AND date < ?',
      whereArgs: [startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch],
      orderBy: 'startTime ASC',
    );

    return List.generate(maps.length, (i) => PlannerActivity.fromMap(maps[i]));
  }

  Future<List<Todo>> getTodosByStatus(bool isDone) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _todosTable,
      where: 'isDone = ?',
      whereArgs: [isDone ? 1 : 0],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
