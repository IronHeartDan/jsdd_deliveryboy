// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsdd_deliveryboy/screen/calendar.dart';

import '../classes.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class UserDetail extends StatefulWidget {
  final Society society;
  final List<Society> societies;

  const UserDetail({Key? key, required this.society, required this.societies})
      : super(key: key);

  @override
  _UserDetailState createState() =>
      _UserDetailState(society: society, societies: societies);
}

class _UserDetailState extends State<UserDetail> {
  final Society society;
  final List<Society> societies;
  List<SUser> users = [];

  _UserDetailState({required this.society, required this.societies});

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() async {
    await societyReference
        .doc(society.d_id)
        .collection("Users")
        .snapshots()
        .listen((event) {
      users = [];
      event.docs.forEach((element) {
        users.add(new SUser(
            d_id: element.id,
            Name: element["Name"],
            Address: element["Address"],
            Phone: element["Phone"]));
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(300, 800),
        orientation: Orientation.portrait);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 31.0.h, left: 15.0.w),
                      height: 45.0.h,
                      width: 45.0.w,
                      child: Image.asset("images/back.png"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text("Society 1",
                            style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Expanded(
                        child: Container(
                          color: Colors.white60,
                          margin: EdgeInsets.only(top: 20.0.h, bottom: 10.0.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Users",
                                    textAlign: TextAlign.left,
                                    // style: TextStyle(
                                    //   fontSize: 27.0,
                                    //   color: Color.fromRGBO(0, 182, 233, 1),
                                    //   fontWeight: FontWeight.bold,
                                    //),
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 27.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 10.0),
                                  child: Text(
                                    "Total Number of user: 10",
                                    textAlign: TextAlign.left,
                                    // style: TextStyle(
                                    //   fontSize: 18.0,
                                    //   // color: Color.fromRGBO(0, 182, 233, 1),
                                    // ),
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: users.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      SUser user = users[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Calendar()));
                                        },
                                        child: Card(
                                          margin: EdgeInsets.only(
                                              top: 15.0.h,
                                              bottom: 12.0.h,
                                              left: 17.0.w,
                                              right: 17.0.w),
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Container(
                                            height: 75.0,
                                            decoration: BoxDecoration(
                                              gradient: (index % 2 == 0)
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Color(0xFF02B3E8),
                                                        Color(0xFF1A55B3),
                                                      ],
                                                      begin: FractionalOffset(
                                                          0.0, 0.0),
                                                      end: FractionalOffset(
                                                          1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp,
                                                    )
                                                  : const LinearGradient(
                                                      colors: [
                                                        Color(0XFFFFFFFF),
                                                        Color(0xFFFFFFFF)
                                                      ],
                                                      begin: FractionalOffset(
                                                          0.0, 0.0),
                                                      end: FractionalOffset(
                                                          1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.0.w, top: 28.0.h),
                                                child: Text(
                                                  user.Name,
                                                  // style: TextStyle(
                                                  //     color: (index % 2 == 0)
                                                  //         ? Colors.white
                                                  //         : Color.fromRGBO(
                                                  //             0, 182, 233, 1),
                                                  //     fontSize: 21.0,
                                                  //     fontWeight:
                                                  //         FontWeight.w500),
                                                  style: GoogleFonts.roboto(
                                                    color: (index % 2 == 0)
                                                        ? Colors.white
                                                        : Color.fromRGBO(
                                                            0, 182, 233, 1),
                                                    fontSize: 22.0.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ]),
                        ),
                      )
                    ])))
          ]),
        )
      ],
    )));
  }
}
