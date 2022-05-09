import 'package:ecomappkoray/blocs/bloc/auth_bloc.dart';
import 'package:ecomappkoray/modals/Product.dart';
import 'package:ecomappkoray/repositories/firestorerepo.dart';
import 'package:ecomappkoray/widgets/BarChart.dart';
import 'package:ecomappkoray/widgets/PieChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.firebaseRepository}) : super(key: key);
  FirebaseRepository firebaseRepository;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool IsWeighted = false;
  TextEditingController _NameController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _ExplanationController = TextEditingController();
  int _MenuIndex = 0;

  String? ProductName;
  double? ProductPrice;
  String? ProductExplanation;
  String PageName = "Anasayfa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: Container(
            child: Center(
              child: const Text(
                "Kontrol Paneli",
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(218, 34, 255, 1),
              Color.fromRGBO(151, 50, 238, 1)
            ])),
          ),
          backgroundColor: Colors.white,
          elevation: 12,
          actions: [
            Center(
              child: Container(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Ara",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
            ),
            Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.notifications,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 6,
                  child: const Text(
                    "1",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                )
              ],
            )
          ],
        ),
        floatingActionButton: PageName == "Ürün Ekle/Çıkar"
            ? FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) => Dialog(
                            child: Container(
                              height: 400,
                              width: 600,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.add)),
                                              const Text("Resim ekle")
                                            ],
                                          ),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80.0),
                                        child: Container(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _NameController,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade100,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                hintText: "Ürün adı"),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value!.length < 1) {
                                                return "Ürün ismi 1 karakterden büyük olmalı";
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 220.0),
                                        child: Container(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _PriceController,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade100,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                hintText: "Ürün fiyatı"),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            onChanged: (value) {
                                              ProductPrice =
                                                  double.tryParse(value);
                                            },
                                            validator: (value) {
                                              if (value!.length < 1) {
                                                return "Ürün ismi 1 karakterden büyük olmalı";
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      IsWeighted = false;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Adet",
                                                    style: TextStyle(
                                                        color:
                                                            IsWeighted == false
                                                                ? Colors.blue
                                                                : Colors.black),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      IsWeighted = true;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Kilo",
                                                    style: TextStyle(
                                                        color:
                                                            IsWeighted == true
                                                                ? Colors.blue
                                                                : Colors.black),
                                                  )),
                                              IsWeighted == true
                                                  ? Container(
                                                      width: 50,
                                                      height: 40,
                                                      child: TextFormField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                        decoration: InputDecoration(
                                                            hintText: "Gram",
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        10),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 580,
                                      child: TextFormField(
                                        controller: _ExplanationController,
                                        minLines: 5,
                                        maxLines: 5,
                                        onChanged: (value) {
                                          ProductExplanation = value;
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          hintText: "Ürün Açıklaması",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Icon(Icons.add),
              )
            : null,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxHeight > 600 && constraints.maxWidth > 800) {
              if (PageName == "Anasayfa")
                return BuildDashboardHomePage();
              else if (PageName == "Ürün Ekle/Çıkar")
                return BuildDashboardProductPage();
              else
                return BuildDashboardNotesPage();
            } else {
              return Container();
            }
          },
        ));
  }

  Row BuildDashboardNotesPage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 200,
          height: double.infinity,
          child: Material(
            elevation: 12,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: const Text(
                      "NAVİGASYON",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _MenuIndex = 0;
                      PageName = "Anasayfa";
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(
                              Icons.dashboard,
                              color: _MenuIndex == 0
                                  ? Colors.blue
                                  : Colors.grey.shade700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Anasayfa",
                              style: TextStyle(
                                  color: _MenuIndex == 0
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Ürün Ekle/Çıkar";
                      _MenuIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.mail,
                                color: _MenuIndex == 1
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Ürün Ekle/Çıkar",
                              style: TextStyle(
                                  color: _MenuIndex == 1
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Not Defteri";
                      _MenuIndex = 2;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.notes,
                                color: _MenuIndex == 2
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Not Defteri",
                              style: TextStyle(
                                  color: _MenuIndex == 2
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(228, 228, 244, 1),
                  Color.fromRGBO(232, 231, 249, 1)
                ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        PageName,
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: GridView.count(
                      padding: const EdgeInsets.all(30),
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue.shade300),
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row BuildDashboardProductPage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 200,
          height: double.infinity,
          child: Material(
            elevation: 12,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: const Text(
                      "NAVİGASYON",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _MenuIndex = 0;
                      PageName = "Anasayfa";
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(
                              Icons.dashboard,
                              color: _MenuIndex == 0
                                  ? Colors.blue
                                  : Colors.grey.shade700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Anasayfa",
                              style: TextStyle(
                                  color: _MenuIndex == 0
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Ürün Ekle/Çıkar";
                      _MenuIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.mail,
                                color: _MenuIndex == 1
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Ürün Ekle/Çıkar",
                              style: TextStyle(
                                  color: _MenuIndex == 1
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Not Defteri";
                      _MenuIndex = 2;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.notes,
                                color: _MenuIndex == 2
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Not Defteri",
                              style: TextStyle(
                                  color: _MenuIndex == 2
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(228, 228, 244, 1),
                  Color.fromRGBO(232, 231, 249, 1)
                ])),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        PageName,
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row BuildDashboardHomePage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 200,
          height: double.infinity,
          child: Material(
            elevation: 12,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: const Text(
                      "NAVİGASYON",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _MenuIndex = 0;
                      PageName = "Anasayfa";
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(
                              Icons.dashboard,
                              color: _MenuIndex == 0
                                  ? Colors.blue
                                  : Colors.grey.shade700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Anasayfa",
                              style: TextStyle(
                                  color: _MenuIndex == 0
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Ürün Ekle/Çıkar";
                      _MenuIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.mail,
                                color: _MenuIndex == 1
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Ürün Ekle/Çıkar",
                              style: TextStyle(
                                  color: _MenuIndex == 1
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PageName = "Not Defteri";
                      _MenuIndex = 2;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Icon(Icons.notes,
                                color: _MenuIndex == 2
                                    ? Colors.blue
                                    : Colors.grey.shade700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Text(
                              "Not Defteri",
                              style: TextStyle(
                                  color: _MenuIndex == 2
                                      ? Colors.blue
                                      : Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(228, 228, 244, 1),
                  Color.fromRGBO(232, 231, 249, 1)
                ])),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        PageName,
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Material(
                        child: Container(
                          width: 260,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: const Text(
                                        "3,235",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 24),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Text(
                                        "Toplam Sipariş",
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Image.asset("assets/images/bin5002.png"),
                              ))
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Material(
                        child: Container(
                          width: 260,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: const Text(
                                        "458",
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 24),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Text(
                                        "Günlük Sipariş",
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Image.asset(
                                    "assets/images/purchase_order_64px.png"),
                              ))
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Material(
                        child: Container(
                          width: 260,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: const Text(
                                        "1,235,637 ₺",
                                        style: TextStyle(
                                            color: Colors.purple, fontSize: 24),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Text(
                                        "Toplam Kazanç",
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Image.asset(
                                    "assets/images/cash_in_hand_64px.png"),
                              ))
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 450,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: BarChartSample1(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 20,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/images/gold_medal_40px.png"),
                            Column(
                              children: [
                                const Text(
                                  "15.235",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 24),
                                ),
                                Text(
                                  "En Çok Satan",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/likee_ap_50px.png"),
                            Column(
                              children: [
                                const Text(
                                  "Ürün Adı",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 24),
                                ),
                                Text(
                                  "En Çok Beğeni Alan",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/feedback_64px.png",
                              scale: 1.2,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Ürün Adı",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 24),
                                ),
                                Text(
                                  "En Çok Yorum Yapılan",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
