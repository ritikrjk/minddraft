import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tasks_controller.dart';
import '../../../utils/notification_service.dart';

class TasksView extends GetView<TasksController> {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (value) {
                  controller.toggleTodoStatus(index);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  _notificationService.showNotification(index, 'Task Reminder', todo.title);
                },
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
                  controller.addTodo(textEditingController.text);
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
}
