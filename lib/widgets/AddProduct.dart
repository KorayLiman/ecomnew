import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecomappkoray/locator.dart';
import 'package:ecomappkoray/modals/Product.dart';
import 'package:ecomappkoray/services/FirebaseProductService.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  bool isWeighted = false;

  Future<void> show(BuildContext context) async {
    await showDialog(context: context, builder: (context) => this);
  }

  var PService = locator<ProductService>();

  String? ProductExplanation;
  String? ProductUrl;
  double? ProductPrice;
  
  String? ProductName;
  int? ProductAmount;
  double? ProductWeight;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {

                          if(ProductAmount == null || ProductWeight == null){
                            if(ProductExplanation !=null &&ProductName != null&&ProductPrice!=null){ Navigator.pop(context);
                          Product NewProduct = Product(
                              Explanation: ProductExplanation!,
                              ImageURL: "",
                              Price: ProductPrice!,
                              ProductID: Uuid().v4(),
                              ProductName: ProductName!,
                              Amount: ProductAmount,
                              Weight: ProductWeight);
                          PService.UploadProduct(NewProduct);}
                           
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
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
                              onChanged: (value) {
                                ProductName = value;
                              },
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
                              onChanged: (value) {
                                ProductPrice = double.tryParse(value);
                              },
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
                            onChanged: (value) {
                              ProductAmount = int.tryParse(value);
                            },
                            readOnly: isWeighted == false ? false : true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: "Adet",
                                hintStyle: TextStyle(
                                    color: isWeighted == false
                                        ? Colors.black
                                        : Colors.red),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: 120,
                          height: 35,
                          child: TextFormField(
                            onChanged: (value) {
                              ProductWeight = double.tryParse(value);
                            },
                            readOnly: isWeighted == true ? false : true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: "Gramaj",
                                hintStyle: TextStyle(
                                    color: isWeighted == false
                                        ? Colors.red
                                        : Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 180,
                      width: 500,
                      child: TextFormField(
                        onChanged: (value) {
                          ProductExplanation = value;
                        },
                        minLines: 10,
                        maxLines: 100,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Ürün Açıklaması",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
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
