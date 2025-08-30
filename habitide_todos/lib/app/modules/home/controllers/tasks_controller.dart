import 'package:get/get.dart';
import '../../../data/models/todo_model.dart';
import '../../../data/providers/local_storage_service.dart';

class TasksController extends GetxController {
  var todos = <Todo>[].obs;
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    _loadTodos();
  }

  void _loadTodos() async {
    todos.value = await _localStorageService.getTodos();
  }

  void addTodo(String title) {
    todos.add(Todo(title: title));
    _localStorageService.saveTodos(todos);
  }

  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
    _localStorageService.saveTodos(todos);
  }
}
