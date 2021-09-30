import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsdd_deliveryboy/screen/viewOrders.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../classes.dart';
import 'addOrder.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class Calendar extends StatefulWidget {
  final SUser user;
  final Society society;

  Calendar({required this.user, required this.society});

  @override
  State<StatefulWidget> createState() => _CalendarState(user, society);
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  final SUser user;
  final Society society;

  _CalendarState(this.user, this.society);

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  List<int> calConList = [];
  double total = 0;
  int _selectedMonth = 1;
  int _offSet = 0;

  ItemScrollController scrollController = ItemScrollController();

  DateTime? today = DateUtils.dateOnly(DateTime.now());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> live;

  @override
  void initState() {
    _selectedMonth = today!.month;
    watch();
    super.initState();
    Future.delayed(Duration.zero, () => _scrollTo());
  }

  _scrollTo() {
    scrollController.scrollTo(
        index: (_selectedMonth - 1), duration: Duration(milliseconds: 1000));
  }

  void watch() async {
    live = await societyReference
        .doc(society.d_id)
        .collection("Users")
        .doc(user.d_id)
        .collection(today!.year.toString())
        .doc(_selectedMonth.toString())
        .collection("MilkData")
        .snapshots()
        .listen((event) {
      getData();
    });
  }

  void getData() async {
    total = 0;
    calConList = [];
    setState(() {});
    await societyReference
        .doc(society.d_id)
        .collection("Users")
        .doc(user.d_id)
        .collection(today!.year.toString())
        .doc(_selectedMonth.toString())
        .collection("MilkData")
        .get()
        .then((value) {
      int length = value.docs.length;
      value.docs.asMap().forEach((docIndex, element) {
        calConList.add(int.parse(element.id));
        element["Orders"].asMap().forEach((index, order) {
          total += double.parse('${order["O_Total"]}');
        });
        if (length == (docIndex + 1)) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _offSet = DateUtils.firstDayOffset(
        today!.year, _selectedMonth, MaterialLocalizations.of(context));

    return Scaffold(
      key: scaffoldKey,
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
            height: MediaQuery.of(context).size.height * 0.12,
            width: double.infinity,
            child: Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 40.0,
                      width: 45.0,
                      child: Image.asset("images/back.png")),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.Name,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400)),
                      )
                    ]),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.12 + 10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(20),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Color(0xFF02B3E8),
                      //         Color(0xFF1A55B3),
                      //       ],
                      //       begin: FractionalOffset(0.0, 0.0),
                      //       end: FractionalOffset(1.0, 0.0),
                      //       stops: [0.0, 1.0],
                      //       tileMode: TileMode.clamp,
                      //     ),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(20))),
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  builder: (context) {
                                    return YearPicker(
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                        selectedDate: today!,
                                        onChanged: (val) {
                                          today = val;
                                          setState(() {});
                                          live.cancel();
                                          watch();
                                          Navigator.pop(context);
                                        });
                                  },
                                  context: context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  today!.year.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_drop_down_circle_sharp)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          height: 40,
                          child: ScrollablePositionedList.builder(
                              itemScrollController: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: months.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedMonth = index + 1;
                                      _offSet = DateUtils.firstDayOffset(
                                          today!.year,
                                          _selectedMonth,
                                          MaterialLocalizations.of(context));
                                      live.cancel();
                                      watch();
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    decoration: _selectedMonth != index + 1
                                        ? BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: _selectedMonth == index + 1
                                                ? null
                                                : Border.all(
                                                    color: Color.fromRGBO(
                                                        2, 179, 232, 1),
                                                    width: 1.0),
                                          )
                                        : BoxDecoration(
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                    margin: EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10, bottom: 5),
                                    child: Center(
                                        child: Text(
                                      months[index],
                                      style: TextStyle(
                                          color: _selectedMonth == index + 1
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 10),
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(2, 179, 232, 1),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            children: [
                              Center(
                                child: Text(
                                  days[0],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[2],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[3],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[4],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[5],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Center(
                                child: Text(
                                  days[6],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: GridView.builder(
                              itemCount: DateUtils.getDaysInMonth(
                                      today!.year, _selectedMonth) +
                                  _offSet,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return index < _offSet
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.grey,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          today = DateTime(
                                              today!.year,
                                              _selectedMonth,
                                              (index + 1 - _offSet));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewOrder(
                                                        society: society,
                                                        user: user,
                                                        dateTime: today!,
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            color: calConList.contains(
                                                    (index + 1 - _offSet))
                                                ? Colors.green
                                                : today!.year >
                                                        DateTime.now().year
                                                    ? Colors.grey
                                                    : today!.year <
                                                            DateTime.now().year
                                                        ? Colors.red
                                                        : today!.year ==
                                                                DateTime.now()
                                                                    .year
                                                            ? _selectedMonth ==
                                                                    DateTime.now()
                                                                        .month
                                                                ? ((index +
                                                                            1 -
                                                                            _offSet) >
                                                                        DateTime.now()
                                                                            .day
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .red)
                                                                : _selectedMonth >
                                                                        DateTime.now()
                                                                            .month
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors.red
                                                            : Colors.red,
                                          ),
                                          child: Center(
                                              child: Text(
                                            (index + 1 - _offSet).toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
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
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Month Total :  ₹ ${total}",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => new AddOrder(
                    user: user,
                    society: society,
                  )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
