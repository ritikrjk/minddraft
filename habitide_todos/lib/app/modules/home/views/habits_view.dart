import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitide_todos/app/data/models/habit_model.dart';

import '../controllers/habits_controller.dart';

class HabitsView extends GetView<HabitsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.habits.length,
          itemBuilder: (context, index) {
            final habit = controller.habits[index];
            return Dismissible(
              key: Key(habit.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteHabit(habit.id);
                Get.snackbar('Habit Deleted', '${habit.title} has been removed.');
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(habit.title),
                trailing: Checkbox(
                  value: habit.isCompletedToday,
                  onChanged: (value) {
                    controller.toggleHabitStatus(habit);
                  },
                ),
                onLongPress: () {
                  _showEditHabitDialog(context, habit);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Habit'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Enter habit title'),
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
                  controller.addHabit(textEditingController.text);
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

  void _showEditHabitDialog(BuildContext context, Habit habit) {
    final TextEditingController textEditingController = TextEditingController(text: habit.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Habit'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Edit habit title'),
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
                  controller.updateHabitTitle(habit, textEditingController.text);
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
