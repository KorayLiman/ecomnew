import 'package:ecomappkoray/modals/Note.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  const NoteItem(
      {Key? key,
      required this.Content,required this.note,
      required this.Id,
      required this.Title,
      required this.color})
      : super(key: key);

  final String Title;
  final String Content;
  final Color color;
  final String Id;
  final Note note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.color,
        ),
        height: 180,
        width: 60,
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            )
          ],
        ),
      ),
    );
  }
}
