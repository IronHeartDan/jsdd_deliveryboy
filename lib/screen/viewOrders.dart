import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class ViewOrder extends StatefulWidget {
  final Society society;
  final SUser user;
  final DateTime dateTime;

  const ViewOrder(
      {Key? key,
      required this.society,
      required this.user,
      required this.dateTime})
      : super(key: key);

  @override
  _ViewOrderState createState() =>
      _ViewOrderState(society: society, user: user, dateTime: dateTime);
}

class _ViewOrderState extends State<ViewOrder> {
  final Society society;
  final SUser user;
  final DateTime dateTime;
  double total = 0.0;

  List<Order> orders = [];

  _ViewOrderState(
      {required this.society, required this.user, required this.dateTime});

  @override
  void initState() {
    // watch();
    getOrders();
    super.initState();
  }

  // void watch() async{
  //   await societyReference
  //       .doc(society.d_id)
  //       .collection("Users")
  //       .doc(user.d_id)
  //       .collection(dateTime.year.toString())
  //       .doc(dateTime.month.toString())
  //       .collection("MilkData")
  //       .doc(dateTime.day.toString())
  //       .snapshots().listen((event) {
  //         print(event.data());
  //     getOrders();
  //   });
  // }

  void getOrders() async {
    await societyReference
        .doc(society.d_id)
        .collection("Users")
        .doc(user.d_id)
        .collection(dateTime.year.toString())
        .doc(dateTime.month.toString())
        .collection("MilkData")
        .doc(dateTime.day.toString())
        .get()
        .then((value) {
      orders = [];
      if (value.exists) {
        value["Orders"].asMap().forEach((index, element) {
          orders.add(new Order(
              index,
              (element["O_Time"] as Timestamp).toDate().toString(),
              element["P_Name"],
              element["P_Price"],
              double.parse(element["P_Quantity"].toString()),
              double.parse(element["O_Total"].toString())));
          total += double.parse('${element["O_Total"]}');
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      dateTime.toString().substring(0, 10),
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1 + 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      Order order = orders[index];
                      return Card(
                        margin: EdgeInsets.only(
                            top: 20.0, bottom: 5.0, left: 15.0, right: 15.0),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                // color: (index % 2 == 0)
                                //     ? Color.fromRGBO(2, 179, 232, 1.0)
                                //     : Colors.white,
                                gradient: (index % 2 == 0)
                                    ? const LinearGradient(
                                        colors: [
                                          const Color(0xFF02B3E8),
                                          const Color(0xFF1A55B3),
                                        ],
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp,
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0XFFFFFFFF),
                                          Color(0xFFFFFFFF)
                                        ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.P_Name,
                                      // color:
                                      //     (index % 2 == 0) ? Colors.white : Colors.black
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: (index % 2 == 0)
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      2, 179, 232, 1),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Text(
                                      "Price : ₹ ${order.P_Price}",
                                      // color:
                                      //     (index % 2 == 0) ? Colors.white : Colors.black,
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: (index % 2 == 0)
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      2, 179, 232, 1),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Quantity : ${order.P_Quantity}",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: (index % 2 == 0)
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      2, 179, 232, 1),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Text(
                                      "Sub-Total : ₹ ${order.O_Total}",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: (index % 2 == 0)
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      2, 179, 232, 1),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      // color: Colors.black87,
                      decoration: BoxDecoration(
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
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Total :  ₹ ${total}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
