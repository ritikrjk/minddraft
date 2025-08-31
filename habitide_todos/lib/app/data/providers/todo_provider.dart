import 'package:habitide_todos/app/data/models/todo_model.dart';
import 'package:habitide_todos/app/data/providers/database_helper.dart';

class TodoProvider {
  final DatabaseHelper _dbHelper;

  TodoProvider(this._dbHelper);

  Future<int> insertTodo(Todo todo) async {
    return await _dbHelper.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query('todos');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> updateTodo(Todo todo) async {
    return await _dbHelper.update(
      'todos',
      todo.toMap(),
      'id = ?',
      [todo.id],
    );
  }

  Future<int> deleteTodo(String id) async {
    return await _dbHelper.delete(
      'todos',
      'id = ?',
      [id],
    );
  }
}
