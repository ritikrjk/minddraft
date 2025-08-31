import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/planner_controller.dart';
import 'package:habitide_todos/app/data/models/planner_model.dart';

class PlannerView extends GetView<PlannerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Planner'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.activities.length,
          itemBuilder: (context, index) {
            final activity = controller.activities[index];
            return Dismissible(
              key: Key(activity.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteActivity(activity.id);
                Get.snackbar('Activity Deleted', '${activity.title} has been removed.');
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(activity.title),
                subtitle: Text(
                    '${activity.startTime.format(context)} - ${activity.endTime.format(context)} on ${activity.date.toLocal().toString().split(' ')[0]}'),
                trailing: Checkbox(
                  value: activity.isCompleted,
                  onChanged: (value) {
                    activity.isCompleted = value!;
                    controller.updateActivity(activity);
                  },
                ),
                onLongPress: () {
                  _showEditActivityDialog(context, activity);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddActivityDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Activity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Enter title'),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text(selectedDate == null
                        ? 'Select Date'
                        : selectedDate!.toLocal().toString().split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(startTime == null
                            ? 'Start Time'
                            : startTime!.format(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              startTime = pickedTime;
                            });
                          }
                        },
                        child: Text('Select'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(endTime == null
                            ? 'End Time'
                            : endTime!.format(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              endTime = pickedTime;
                            });
                          }
                        },
                        child: Text('Select'),
                      ),
                    ],
                  ),
                ],
              );
            },
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
                if (titleController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null &&
                    selectedDate != null) {
                  controller.addActivity(
                    titleController.text,
                    startTime!,
                    endTime!,
                    selectedDate!,
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

  void _showEditActivityDialog(BuildContext context, PlannerActivity activity) {
    final TextEditingController titleController = TextEditingController(text: activity.title);
    TimeOfDay? startTime = activity.startTime;
    TimeOfDay? endTime = activity.endTime;
    DateTime? selectedDate = activity.date;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Activity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Edit title'),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text(selectedDate == null
                        ? 'Select Date'
                        : selectedDate!.toLocal().toString().split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(startTime == null
                            ? 'Start Time'
                            : startTime!.format(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: startTime ?? TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              startTime = pickedTime;
                            });
                          }
                        },
                        child: Text('Select'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(endTime == null
                            ? 'End Time'
                            : endTime!.format(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: endTime ?? TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              endTime = pickedTime;
                            });
                          }
                        },
                        child: Text('Select'),
                      ),
                    ],
                  ),
                ],
              );
            },
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
                if (titleController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null &&
                    selectedDate != null) {
                  activity.title = titleController.text;
                  activity.startTime = startTime!;
                  activity.endTime = endTime!;
                  activity.date = selectedDate!;
                  controller.updateActivity(activity);
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