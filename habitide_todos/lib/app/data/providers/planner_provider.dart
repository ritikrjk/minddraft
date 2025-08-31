import 'package:habitide_todos/app/data/models/planner_model.dart';
import 'package:habitide_todos/app/data/providers/database_helper.dart';

class PlannerProvider {
  final DatabaseHelper _dbHelper;

  PlannerProvider(this._dbHelper);

  Future<int> insertPlannerActivity(PlannerActivity activity) async {
    return await _dbHelper.insert('planner_activities', activity.toMap());
  }

  Future<List<PlannerActivity>> getPlannerActivities() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query('planner_activities');
    return List.generate(maps.length, (i) {
      return PlannerActivity.fromMap(maps[i]);
    });
  }

  Future<int> updatePlannerActivity(PlannerActivity activity) async {
    return await _dbHelper.update(
      'planner_activities',
      activity.toMap(),
      'id = ?',
      [activity.id],
    );
  }

  Future<int> deletePlannerActivity(String id) async {
    return await _dbHelper.delete(
      'planner_activities',
      'id = ?',
      [id],
    );
  }
}
