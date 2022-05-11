import 'package:ecomappkoray/modals/Note.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorage {
  Future<bool> AddNote({required Note note});
  Future<List<Note>> GetAllNotes();
  Future<Note?> GetNote({required String ID});
  Future<bool> DeleteNote({required Note note});
  Future<Note> UpdateNote({required Note note});
}

class HiveLocalStorage extends LocalStorage {
  late Box<Note> _NoteBox;
  HiveLocalStorage() {
    _NoteBox = Hive.box<Note>("NoteBox");
  }

  @override
  Future<bool> AddNote({required Note note}) async {
    try {
      await _NoteBox.put(note.ID, note);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<bool> DeleteNote({required Note note}) async {
    try {
      await note.delete();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<List<Note>> GetAllNotes() async {
    List<Note> _AllNotes = <Note>[];
    List<Note> Notes = <Note>[];
    _AllNotes = _NoteBox.values.toList();
    _AllNotes.forEach((element) {
      Notes.add(element);
    });
    if (Notes.isNotEmpty) {
      Notes.sort((Note a, Note b) => a.CreatedAt.compareTo(b.CreatedAt));
    }
    return Notes;
  }

  @override
  Future<Note?> GetNote({required String ID}) async {
    if (_NoteBox.containsKey(ID)) {
      return _NoteBox.get(ID);
    } else {
      return null;
    }
  }

  @override
  Future<Note> UpdateNote({required Note note}) async {
    await note.save();
    return note;
  }
}
