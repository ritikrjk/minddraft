import 'package:get/get.dart';
import '../../../data/models/note_model.dart';
import '../../../data/providers/local_storage_service.dart';

class NotesController extends GetxController {
  var notes = <Note>[].obs;
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  void _loadNotes() async {
    notes.value = await _localStorageService.getNotes();
  }

  void addNote(String title, String content) {
    notes.add(Note(title: title, content: content));
    _localStorageService.saveNotes(notes);
  }
}
