import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/data/providers/database_helper.dart';
import 'app/data/providers/habit_provider.dart';
import 'app/data/providers/note_provider.dart';
import 'app/data/providers/planner_provider.dart';
import 'app/data/providers/todo_provider.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';
import 'app/utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  Get.put(notificationService);

  // Initialize DatabaseHelper and register providers
  final DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.database; // Ensure database is initialized

  Get.put(dbHelper);
  Get.put(HabitProvider(dbHelper));
  Get.put(NoteProvider(dbHelper));
  Get.put(PlannerProvider(dbHelper));
  Get.put(TodoProvider(dbHelper));

  runApp(
    GetMaterialApp(
      title: "HabiTide & Todos",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.dark,
    ),
  );
}


