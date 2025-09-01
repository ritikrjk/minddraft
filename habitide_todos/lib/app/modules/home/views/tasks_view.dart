import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tasks_controller.dart';
import '../../../utils/notification_service.dart';
import 'package:habitide_todos/app/data/models/todo_model.dart';

class TasksView extends GetView<TasksController> {
  final NotificationService _notificationService =
      Get.find<NotificationService>();

  TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return Dismissible(
              key: Key(todo.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteTodo(todo.id);
                Get.snackbar('Task Deleted', '${todo.title} has been removed.');
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                child: ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (value) {
                      controller.toggleTodoStatus(todo.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      _notificationService.showNotification(
                        int.parse(todo.id.substring(0, 9)),
                        'Task Reminder',
                        todo.title,
                      );
                    },
                  ),
                  onLongPress: () {
                    _showEditTaskDialog(context, todo);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  controller.addTodo(textEditingController.text, 'Medium', 'Work');
                  Get.back();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Todo todo) {
    final TextEditingController textEditingController = TextEditingController(
      text: todo.title,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Edit task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  controller.updateTodo(todo.id, textEditingController.text);
                  Get.back();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
