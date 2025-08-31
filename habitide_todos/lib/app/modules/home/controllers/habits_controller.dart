import 'package:get/get.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/providers/habit_provider.dart';
import 'package:habitide_todos/app/utils/id_generator.dart';

class HabitsController extends GetxController {
  var habits = <Habit>[].obs;
  late HabitProvider _habitProvider;

  @override
  void onInit() {
    super.onInit();
    _habitProvider = Get.find<HabitProvider>();
    _loadHabits();
  }

  void _loadHabits() async {
    habits.value = await _habitProvider.getHabits();
  }

  void addHabit(String title) async {
    final newHabit = Habit(id: IdGenerator.generateId(), title: title);
    await _habitProvider.insertHabit(newHabit);
    habits.add(newHabit);
  }

  void toggleHabitStatus(Habit habit) async {
    habit.isCompletedToday = !habit.isCompletedToday;
    await _habitProvider.updateHabit(habit);
    habits.refresh();
  }

  void deleteHabit(String id) async {
    await _habitProvider.deleteHabit(id);
    habits.removeWhere((habit) => habit.id == id);
  }

  void updateHabitTitle(Habit habit, String newTitle) async {
    habit.title = newTitle;
    await _habitProvider.updateHabit(habit);
    habits.refresh();
  }
}
