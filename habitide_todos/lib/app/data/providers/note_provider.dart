import 'package:habitide_todos/app/data/models/note_model.dart';
import 'package:habitide_todos/app/data/providers/database_helper.dart';

class NoteProvider {
  final DatabaseHelper _dbHelper;

  NoteProvider(this._dbHelper);

  Future<int> insertNote(Note note) async {
    return await _dbHelper.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> updateNote(Note note) async {
    return await _dbHelper.update(
      'notes',
      note.toMap(),
      'id = ?',
      [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    return await _dbHelper.delete(
      'notes',
      'id = ?',
      [id],
    );
  }
}
