import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/planner_model.dart';
import '../../../data/providers/local_storage_service.dart';

class PlannerController extends GetxController {
  var activities = <PlannerActivity>[].obs;
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    _loadActivities();
  }

  void _loadActivities() async {
    activities.value = await _localStorageService.getPlannerActivities();
  }

  void addActivity(String title, TimeOfDay startTime, TimeOfDay endTime) {
    activities.add(PlannerActivity(title: title, startTime: startTime, endTime: endTime));
    _localStorageService.savePlannerActivities(activities);
  }
}
