import 'package:habitide_todos/app/data/models/note_model.dart';
import 'package:habitide_todos/app/data/providers/sqlite_storage_service.dart';

class NoteProvider {
  final SQLiteStorageService _dbHelper;

  NoteProvider(this._dbHelper);

  Future<void> insertNote(Note note) async {
    return await _dbHelper.addNote(note);
  }

  Future<List<Note>> getNotes() async {
    return await _dbHelper.getNotes();
  }

  Future<void> updateNote(Note note) async {
    return await _dbHelper.updateNote(note);
  }

  Future<void> deleteNote(String id) async {
    return await _dbHelper.deleteNote(id);
  }
}
