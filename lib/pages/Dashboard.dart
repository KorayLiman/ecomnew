import 'package:ecomappkoray/blocs/bloc/auth_bloc.dart';
import 'package:ecomappkoray/modals/Product.dart';
import 'package:ecomappkoray/repositories/firestorerepo.dart';
import 'package:ecomappkoray/widgets/BarChart.dart';
import 'package:ecomappkoray/widgets/PieChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

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
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 98.0),
            child: const Text(
              "E Ticaret",
              style: TextStyle(color: Colors.black),
            ),
          ),
          leadingWidth: 500,
          leading: Container(
            child: Row(
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(218, 34, 255, 1),
                    Color.fromRGBO(151, 50, 238, 1)
                  ])),
                  child: Center(
                    child: const Text(
                      "Kontrol Paneli",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Center(
                  child: Container(
                      width: 200,
                      height: 32,
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.only(
                                left: 6, right: 0, top: 0, bottom: 0),
                            hintStyle: TextStyle(),
                            hintText: "Ara",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      )),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 12,
          actions: [
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
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  splashRadius: 16,
                  onPressed: () {},
                  icon: Icon(Icons.settings, color: Colors.grey.shade700)),
            )
          ],
        ),
        floatingActionButton: PageName == "Ürün Ekle/Çıkar"
            ? GradientFloatingActionButton.extended(
                onPressed: () {},
                label: const Text("Ürün Ekle"),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(240, 43, 17, 1),
                  Color.fromRGBO(244, 171, 25, 1)
                ]))
            : PageName == "Not Defteri"
                ? GradientFloatingActionButton.extended(
                    onPressed: () {},
                    label: const Text("Not Ekle"),
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(240, 43, 17, 1),
                      Color.fromRGBO(244, 171, 25, 1)
                    ]))
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
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                            height: 180,
                            width: 60,
                            color: index == 0
                                ? Colors.blue.shade400
                                : index == 1
                                    ? Colors.orange.shade400
                                    : index == 2
                                        ? Colors.green.shade400
                                        : index == 3
                                            ? Colors.pink.shade400
                                            : Colors.blue);
                      }),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: BarChartSample1()),
                        Expanded(child: PieChartSample2()),
                      ],
                    ),
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
