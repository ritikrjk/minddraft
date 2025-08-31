import 'package:habitide_todos/app/data/models/planner_model.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';

class PlannerProvider {
  final SQLiteStorageService _dbHelper;

  PlannerProvider(this._dbHelper);

  Future<void> insertPlannerActivity(PlannerActivity activity) async {
    return await _dbHelper.addPlannerActivity(activity);
  }

  Future<List<PlannerActivity>> getPlannerActivities() async {
    return await _dbHelper.getPlannerActivities();
  }

  Future<void> updatePlannerActivity(PlannerActivity activity) async {
    return await _dbHelper.updatePlannerActivity(activity);
  }

  Future<void> deletePlannerActivity(String id) async {
    return await _dbHelper.deletePlannerActivity(id);
  }
}
