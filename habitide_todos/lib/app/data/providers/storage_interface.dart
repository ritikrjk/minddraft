import 'package:habitide_todos/app/data/models/habit_model.dart';
import 'package:habitide_todos/app/data/models/note_model.dart';
import 'package:habitide_todos/app/data/models/planner_model.dart';
import 'package:habitide_todos/app/data/models/todo_model.dart';

abstract class StorageInterface {
  // Generic CRUD operations
  Future<T> create<T>(T item);
  Future<T?> read<T>(String id);
  Future<List<T>> readAll<T>();
  Future<T> update<T>(T item);
  Future<bool> delete<T>(String id);
  
  // Specific operations for each model
  Future<List<Todo>> getTodos();
  Future<void> saveTodos(List<Todo> todos);
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
  
  Future<List<Habit>> getHabits();
  Future<void> saveHabits(List<Habit> habits);
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(String id);
  
  Future<List<Note>> getNotes();
  Future<void> saveNotes(List<Note> notes);
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  
  Future<List<PlannerActivity>> getPlannerActivities();
  Future<void> savePlannerActivities(List<PlannerActivity> activities);
  Future<void> addPlannerActivity(PlannerActivity activity);
  Future<void> updatePlannerActivity(PlannerActivity activity);
  Future<void> deletePlannerActivity(String id);
}
