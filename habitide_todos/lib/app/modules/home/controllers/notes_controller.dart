import 'package:get/get.dart';
import '../../../data/models/note_model.dart';
import '../../../data/providers/note_provider.dart';
import 'package:habitide_todos/app/utils/id_generator.dart';

class NotesController extends GetxController {
  var notes = <Note>[].obs;
  late NoteProvider _noteProvider;

  @override
  void onInit() {
    super.onInit();
    _noteProvider = Get.find<NoteProvider>();
    _loadNotes();
  }

  void _loadNotes() async {
    notes.value = await _noteProvider.getNotes();
  }

  void addNote(String title, String content) async {
    final newNote = Note(id: IdGenerator.generateId(), title: title, content: content);
    await _noteProvider.insertNote(newNote);
    notes.add(newNote);
  }

  void updateNote(Note note) async {
    await _noteProvider.updateNote(note);
    notes.refresh();
  }

  void deleteNote(String id) async {
    await _noteProvider.deleteNote(id);
    notes.removeWhere((note) => note.id == id);
  }
}
