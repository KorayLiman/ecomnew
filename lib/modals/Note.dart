import 'package:hive/hive.dart';
part "Note.g.dart";

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String NoteTitle;
  @HiveField(1)
  String NoteContent;
  @HiveField(2)
  final DateTime CreatedAt;
  @HiveField(3)
  bool IsCompleted;
  Note(
      {required this.NoteTitle,
      required this.NoteContent,
      required this.CreatedAt,
      required this.IsCompleted});
  factory Note.create(
      {required String NoteTitle,
      required String NoteContent,
      required DateTime CreatedAt,
      required bool IsCompleted}) {
    return Note(
        NoteTitle: NoteTitle,
        NoteContent: NoteContent,
        CreatedAt: CreatedAt,
        IsCompleted: IsCompleted);
  }
}
