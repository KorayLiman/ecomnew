import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomappkoray/modals/Note.dart';

class FirebaseNoteService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> AddNote(Note note) async {
    _firebaseFirestore.collection("Notes").doc(note.ID).set(note.ToMap());
  }
}
