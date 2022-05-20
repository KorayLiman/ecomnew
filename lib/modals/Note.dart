import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part "Note.g.dart";

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String NoteTitle;
  @HiveField(1)
  String NoteContent;
  @HiveField(2)
  final DateTime CreatedAt;
  @HiveField(3)
  bool IsCompleted;
  @HiveField(4)
  String ID;
  @HiveField(5)
  int ColorValue;
  Note(
      {required this.NoteTitle,
      required this.ColorValue,
      required this.ID,
      required this.NoteContent,
      required this.CreatedAt,
      required this.IsCompleted});
  factory Note.create(
      {required String NoteTitle,
      required int ColorValue,
      required String ID,
      required String NoteContent,
      required DateTime CreatedAt,
      required bool IsCompleted}) {
    return Note(
        ID: ID,
        ColorValue: ColorValue,
        NoteTitle: NoteTitle,
        NoteContent: NoteContent,
        CreatedAt: CreatedAt,
        IsCompleted: IsCompleted);
  }

  Map<String, dynamic> ToMap() {
    return {
      "NoteTitle": NoteTitle,
      "NoteContent": NoteContent,
      "IsCompleted": IsCompleted,
      "CreatedAt": FieldValue.serverTimestamp(),
      "ColorValue": ColorValue,
      "ID": ID
    };
  }

  Note.FromMap(Map<String, dynamic> map)
      : NoteTitle = map["NoteTitle"],
        ColorValue = map["ColorValue"],
        CreatedAt = map["CreatedAt"],
        ID = map["ID"],
        IsCompleted = map["IsCompleted"],
        NoteContent = map["NoteContent"];

/*


  Product.FromMap(Map<String, dynamic> map)
      : ProductID = map["ProductID"],
        ProductName = map["ProductName"],
        ImageURL = map["ImageURL"],
        Price = map["Price"],
        Explanation = map["Explanation"],
        Amount = map["Amount"],
        Weight = map["Weight"]; */
}
