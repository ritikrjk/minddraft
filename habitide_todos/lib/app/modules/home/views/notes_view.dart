import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notes_controller.dart';
import 'package:habitide_todos/app/data/models/note_model.dart';

class NotesView extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return Dismissible(
              key: Key(note.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteNote(note.id);
                Get.snackbar('Note Deleted', '${note.title} has been removed.');
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onLongPress: () {
                  _showEditNoteDialog(context, note);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Enter title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Enter content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  controller.addNote(
                    titleController.text,
                    contentController.text,
                  );
                  Get.back();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(BuildContext context, Note note) {
    final TextEditingController titleController = TextEditingController(text: note.title);
    final TextEditingController contentController = TextEditingController(text: note.content);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Edit title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Edit content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  note.title = titleController.text;
                  note.content = contentController.text;
                  controller.updateNote(note);
                  Get.back();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}