import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:toast/toast.dart';

import '../classes.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference proReference =
    firebaseFirestore.collection("products");

final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class AddOrder extends StatefulWidget {
  final SUser user;
  final Society society;

  AddOrder({required this.user, required this.society});

  @override
  State<StatefulWidget> createState() => _AddOrderState(user, society);
}

class _AddOrderState extends State<AddOrder> {
  final SUser user;
  final Society society;

  _AddOrderState(this.user, this.society);

  late DateTime? today;
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerTotal = TextEditingController();
  List<Product> products = [];
  late String _selectedPro = "0";
  late double _quantity = 1.0;
  HashMap<String, Product> prices = HashMap<String, Product>();

  @override
  void initState() {
    DateTime now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);
    _controllerDate.text = today.toString().substring(0, 10);
    _controllerPrice.text = "₹ 0";
    _controllerTotal.text = "₹ 0";
    getPro();
    super.initState();
  }

  void getPro() async {
    prices['0'] = Product(d_id: "0", Name: "Name", Price: "0");
    await proReference.get().then((value) {
      value.docs.forEach((element) {
        products.add(Product(
            d_id: element.id,
            Name: element['productname'],
            Price: element['productprice']));
        prices[element.id] = Product(
            d_id: element.id,
            Name: element['productname'],
            Price: element['productprice']);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              // color: const Color.fromRGBO(0, 182, 233, 0.9),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF02B3E8),
                    Color(0xFF1A55B3),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 45.0,
                        width: 45.0,
                        child: Image.asset("images/back.png")),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Place Order",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ]),
            ),
            Container(
              height: double.infinity,
              // padding: EdgeInsets.all(15),
              padding: EdgeInsets.only(top: 45, bottom: 15),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1 + 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      new TextFormField(
                        onTap: () async {
                          today = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          _controllerDate.text =
                              today.toString().substring(0, 10);
                        },
                        controller: _controllerDate,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        readOnly: true,
                        decoration: new InputDecoration(
                          counterText: "",
                          labelText: "Date",
                          border: new OutlineInputBorder(
                            gapPadding: 7,
                            borderRadius: new BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: SearchableDropdown.single(
                          underline: Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          displayClearIcon: false,
                          isExpanded: true,
                          hint: "Select Product",
                          value: _selectedPro,
                          items: products.map((item) {
                            return DropdownMenuItem<String>(
                              child: Text(item.Name),
                              value: item.d_id,
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedPro = newValue;
                              _controllerPrice.text =
                                  "₹ ${prices[_selectedPro]!.Price}";
                              _controllerTotal.text =
                                  "₹ ${double.parse(prices[_selectedPro]!.Price) * _quantity}";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: _controllerPrice,
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            counterText: "",
                            labelText: "Price",
                            border: new OutlineInputBorder(
                              gapPadding: 7,
                              borderRadius: new BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new TextFormField(
                          initialValue: _quantity.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _quantity = double.parse(value);
                              _controllerTotal.text =
                                  "₹ ${double.parse(prices[_selectedPro]!.Price) * _quantity}";
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            counterText: "",
                            labelText: "Quantity",
                            border: new OutlineInputBorder(
                              gapPadding: 7,
                              borderRadius: new BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          readOnly: true,
                          controller: _controllerTotal,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            counterText: "",
                            labelText: "Total",
                            border: new OutlineInputBorder(
                              gapPadding: 7,
                              borderRadius: new BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedPro != "0") {
            DocumentReference milkData_reference = societyReference
                .doc(society.d_id)
                .collection("Users")
                .doc(user.d_id);

            CollectionReference y_reference =
                milkData_reference.collection(today!.year.toString());

            CollectionReference m_reference =
                y_reference.doc(today!.month.toString()).collection("MilkData");

            DocumentReference d_reference =
                m_reference.doc(today!.day.toString());

            d_reference.get().then((value) {
              if (value.exists) {
                print("Exists");

                milkData_reference
                    .collection(today!.year.toString())
                    .doc(today!.month.toString())
                    .collection("MilkData")
                    .doc(today!.day.toString())
                    .update({
                  "Orders": FieldValue.arrayUnion([
                    {
                      "O_Time": Timestamp.now(),
                      "P_Name": prices[_selectedPro]!.Name,
                      "P_Price": prices[_selectedPro]!.Price,
                      "P_Quantity": _quantity,
                      "O_Total":
                          double.parse(prices[_selectedPro]!.Price) * _quantity,
                    }
                  ])
                }).then((value) async {
                  double mTotal = 0;

                  await societyReference
                      .doc(society.d_id)
                      .collection("Users")
                      .doc(user.d_id)
                      .collection(today!.year.toString())
                      .doc(today!.month.toString())
                      .collection("MilkData")
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      element["Orders"].asMap().forEach((index, order) {
                        mTotal += double.parse('${order["O_Total"]}');
                      });
                    });
                    milkData_reference
                        .collection(today!.year.toString())
                        .doc(today!.month.toString())
                        .update({"M_Total": mTotal}).then((value) {
                      Toast.show("Order Added", context);
                      Navigator.pop(context);
                    });
                  });
                });
              } else {
                print("Not Exists");

                milkData_reference
                    .collection(today!.year.toString())
                    .doc(today!.month.toString())
                    .collection("MilkData")
                    .doc(today!.day.toString())
                    .set({
                  "Orders": [
                    {
                      "O_Time": Timestamp.now(),
                      "P_Name": prices[_selectedPro]!.Name,
                      "P_Price": prices[_selectedPro]!.Price,
                      "P_Quantity": _quantity,
                      "O_Total":
                          double.parse(prices[_selectedPro]!.Price) * _quantity,
                    }
                  ]
                }).then((value) async {
                  double mTotal = 0;
                  print("Inserted!!!");

                  await societyReference
                      .doc(society.d_id)
                      .collection("Users")
                      .doc(user.d_id)
                      .collection(today!.year.toString())
                      .doc(today!.month.toString())
                      .collection("MilkData")
                      .get()
                      .then((value) {
                    print("Check : ${value.docs.length}");
                    value.docs.forEach((element) {
                      element["Orders"].asMap().forEach((index, order) {
                        mTotal += double.parse('${order["O_Total"]}');
                      });
                    });
                    print("Y : ${today!.year} , M : ${today!.month}");
                    milkData_reference
                        .collection(today!.year.toString())
                        .doc(today!.month.toString())
                        .set({
                      "Month": today!.month,
                      "CreatedAt": new Timestamp.now(),
                      "M_Total": mTotal,
                      "Paid": false
                    }).then((value) {
                      Toast.show("Order Added", context);
                      Navigator.pop(context);
                    });
                  });
                });
              }
            });
          } else {
            Toast.show("Please Select Product", context, gravity: Toast.BOTTOM);
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
