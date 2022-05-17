import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecomappkoray/data/LocalStorage.dart';
import 'package:ecomappkoray/locator.dart';
import 'package:ecomappkoray/modals/Note.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    required this.note,
    Key? key,
  }) : super(key: key);

  final Note note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late LocalStorage _localStorage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localStorage = locator<LocalStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(widget.note.ColorValue),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: widget.note.IsCompleted,
                    onChanged: (value) {
                      setState(() {
                        widget.note.IsCompleted = value!;
                        _localStorage.UpdateNote(note: widget.note);
                      });
                    }),
                Container(
                  height: 30,
                  child: Center(child: Text(widget.note.NoteTitle)),
                  color: Color(widget.note.ColorValue),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                    child: const Text("Hayır"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _localStorage.DeleteNote(note: widget.note);
                                    setState(() {});
                                  },
                                  child: const Text(
                                    "Sil",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                              title: const Text("Sil"),
                              content: const Text(
                                  "Silmek istediğinize emin misiniz?"),
                            );
                          });
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            AutoSizeText(
              widget.note.NoteContent,
              maxFontSize: 18,
            )
          ],
        ),
      ),
    );
  }
}
