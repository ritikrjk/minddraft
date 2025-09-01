import 'package:get/get.dart';
import '../../../data/models/todo_model.dart';
import '../../../data/providers/todo_provider.dart';
import 'package:habitide_todos/app/utils/id_generator.dart';

class TasksController extends GetxController {
  var todos = <Todo>[].obs;
  late TodoProvider _todoProvider;

  @override
  void onInit() {
    super.onInit();
    _todoProvider = Get.find<TodoProvider>();
    _loadTodos();
  }

  void _loadTodos() async {
    try {
      todos.value = await _todoProvider.getTodos();
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  void addTodo(String title, String priority, String category) async {
    final todo = Todo(
      id: IdGenerator.generateId(),
      title: title,
      priority: priority,
      category: category,
      isDone: false,
      createdAt: DateTime.now(),
    );
    await _todoProvider.insertTodo(todo);
    todos.add(todo);
  }

  void updateTodo(String id, String newTitle) async {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final updatedTodo = todos[index].copyWith(title: newTitle);
      await _todoProvider.updateTodo(updatedTodo);
      todos[index] = updatedTodo;
      todos.refresh();
    }
  }

  void toggleTodoStatus(String id) async {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final isDone = !todos[index].isDone;
      final completedAt = isDone ? DateTime.now() : null;
      final updatedTodo = todos[index].copyWith(
        isDone: isDone,
        completedAt: completedAt,
      );
      await _todoProvider.updateTodo(updatedTodo);
      todos[index] = updatedTodo;
      todos.refresh();
    }
  }

  void deleteTodo(String id) async {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      await _todoProvider.deleteTodo(id);
      todos.removeAt(index);
      todos.refresh();
    }
  }

  List<Todo> getPendingTodos() {
    return todos.where((todo) => !todo.isDone).toList();
  }

  List<Todo> getCompletedTodos() {
    return todos.where((todo) => todo.isDone).toList();
  }

  int get completedCount => todos.where((todo) => todo.isDone).length;
  int get totalCount => todos.length;
  double get completionRate => totalCount > 0 ? completedCount / totalCount : 0.0;
}
