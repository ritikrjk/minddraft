
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habitide_todos/app/data/providers/planner_provider.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';
import 'package:habitide_todos/app/modules/home/controllers/home_controller.dart';
import 'package:habitide_todos/app/modules/home/controllers/planner_controller.dart';
import 'package:habitide_todos/app/modules/home/views/home_view.dart';
import 'package:habitide_todos/app/utils/notification_service.dart';

void main() {
  testWidgets('HomeView renders correctly', (WidgetTester tester) async {
    Get.put(SQLiteStorageService());
    Get.put(PlannerProvider(Get.find()));
    Get.put(HomeController());
    Get.put(NotificationService());
    Get.put(PlannerController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: HomeView(),
      ),
    );

    expect(find.byType(HomeView), findsOneWidget);
  });
}
