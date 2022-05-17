import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  bool isWeighted = false;

  Future<void> show(BuildContext context) async {
    await showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > 600 && constraints.maxWidth > 800) {
          return Dialog(child: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: 650,
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 25),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.image)),
                                const AutoSizeText(
                                  "Ürün fotoğrafı ekle",
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 118.0),
                        child: Container(
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: "Ürün adı",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none))),
                          width: 200,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 96.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: "Ürün fiyatı",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none))),
                          width: 200,
                          height: 50,
                        ),
                        Switch(
                            value: isWeighted,
                            onChanged: (value) {
                              setState(() {
                                isWeighted = value;
                              });
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          width: 120,
                          height: 35,
                          child: TextFormField(
                            readOnly: isWeighted == false ? false : true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: "Adet",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          width: 120,
                          height: 35,
                          child: TextFormField(
                            readOnly: isWeighted == true ? false : true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: "Gramaj",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }));
        } else {
          return Container();
        }
      },
    );
  }
}
