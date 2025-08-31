import 'package:habitide_todos/app/data/models/todo_model.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';

class TodoProvider {
  final SQLiteStorageService _dbHelper;

  TodoProvider(this._dbHelper);

  Future<void> insertTodo(Todo todo) async {
    return await _dbHelper.addTodo(todo);
  }

  Future<List<Todo>> getTodos() async {
    return await _dbHelper.getTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    return await _dbHelper.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    return await _dbHelper.deleteTodo(id);
  }
}
