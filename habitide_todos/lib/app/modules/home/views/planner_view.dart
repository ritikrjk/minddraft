import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/planner_controller.dart';

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
            return ListTile(
              title: Text(activity.title),
              subtitle: Text(
                  '${activity.startTime.format(context)} - ${activity.endTime.format(context)}'),
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

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Enter title'),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Start Time'),
                  ),
                  TextButton(
                    onPressed: () async {
                      startTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    },
                    child: Text('Select'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('End Time'),
                  ),
                  TextButton(
                    onPressed: () async {
                      endTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    },
                    child: Text('Select'),
                  ),
                ],
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
                if (titleController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null) {
                  controller.addActivity(
                    titleController.text,
                    startTime!,
                    endTime!,
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
}