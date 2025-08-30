import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            return ListTile(
              title: Text(habit.title),
              trailing: Checkbox(
                value: habit.isCompletedToday,
                onChanged: (value) {
                  controller.toggleHabitStatus(index);
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
}