
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitide_todos/app/data/models/habit_model.dart';
import 'package:habitide_todos/app/utils/app_constants.dart'; // Added import

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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String selectedCategory = 'Others';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Enter habit title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Enter habit description'),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedCategory = newValue;
                  }
                },
                items: AppConstants.habitCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ],
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
                if (titleController.text.isNotEmpty) {
                  controller.addHabit(
                    titleController.text,
                    descriptionController.text,
                    selectedCategory,
                  );
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
    final TextEditingController titleController = TextEditingController(text: habit.title);
    final TextEditingController descriptionController = TextEditingController(text: habit.description);
    String selectedCategory = habit.category;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Edit habit title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Edit habit description'),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedCategory = newValue;
                  }
                },
                items: AppConstants.habitCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ],
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
                if (titleController.text.isNotEmpty) {
                  controller.updateHabit(
                    habit,
                    titleController.text,
                    descriptionController.text,
                    selectedCategory,
                  );
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
