import 'package:get/get.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/providers/local_storage_service.dart';

class HabitsController extends GetxController {
  var habits = <Habit>[].obs;
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    _loadHabits();
  }

  void _loadHabits() async {
    habits.value = await _localStorageService.getHabits();
  }

  void addHabit(String title) {
    habits.add(Habit(title: title));
    _localStorageService.saveHabits(habits);
  }

  void toggleHabitStatus(int index) {
    habits[index].isCompletedToday = !habits[index].isCompletedToday;
    habits.refresh();
    _localStorageService.saveHabits(habits);
  }
}
