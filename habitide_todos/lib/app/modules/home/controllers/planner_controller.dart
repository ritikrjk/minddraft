import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/planner_model.dart';
import '../../../data/providers/planner_provider.dart';
import 'package:habitide_todos/app/utils/id_generator.dart';

class PlannerController extends GetxController {
  var activities = <PlannerActivity>[].obs;
  late PlannerProvider _plannerProvider;

  @override
  void onInit() {
    super.onInit();
    _plannerProvider = Get.find<PlannerProvider>();
    _loadActivities();
  }

  void _loadActivities() async {
    activities.value = await _plannerProvider.getPlannerActivities();
  }

  void addActivity(String title, TimeOfDay startTime, TimeOfDay endTime, DateTime date) async {
    final newActivity = PlannerActivity(
      id: IdGenerator.generateId(),
      title: title,
      startTime: startTime,
      endTime: endTime,
      date: date,
    );
    await _plannerProvider.insertPlannerActivity(newActivity);
    activities.add(newActivity);
  }

  void updateActivity(PlannerActivity activity) async {
    await _plannerProvider.updatePlannerActivity(activity);
    activities.refresh();
  }

  void deleteActivity(String id) async {
    await _plannerProvider.deletePlannerActivity(id);
    activities.removeWhere((activity) => activity.id == id);
  }
}
