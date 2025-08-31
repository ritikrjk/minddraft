import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/providers/sqlite_storage_service.dart';
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

  // Initialize SQLiteStorageService and register providers
  final SQLiteStorageService storageService = SQLiteStorageService();
  await storageService.database; // Ensure database is initialized

  Get.put(storageService);
  Get.put(HabitProvider(storageService));
  Get.put(NoteProvider(storageService));
  Get.put(PlannerProvider(storageService));
  Get.put(TodoProvider(storageService));

  runApp(
    GetMaterialApp(
      title: "HabiTide & Todos",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.dark,
    ),
  );
}
