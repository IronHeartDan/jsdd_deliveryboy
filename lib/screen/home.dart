// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsdd_deliveryboy/screen/userdetail.dart';

import '../classes.dart';
import 'login.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String uid;

  List<Society> societies = [];
  List<Society> searchedSocieties = [];
  final TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await societyReference.orderBy("S_Name").snapshots().listen((event) {
      societies = [];
      event.docs.forEach((element) {
        societies.add(
            new Society(d_id: element.id, name: element["S_Name"].toString()));
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset(
                    "images/nav.png",
                  ),
                ),
              );
            },
          ),
          title: Text(
            "JAN SAKTI DUDH DEPO",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        drawer: Container(
            // margin: EdgeInsets.only(top: 35.0.h, bottom: 10.0.h),
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: -10,
                  blurRadius: 5,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
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
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          // make it responsive
                          margin: const EdgeInsets.only(top: 30.0),
                          height: 70.0,
                          width: 55.0,
                          // color: Colors.deepOrange,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            "images/dp.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hello User",
                                  // textAlign: TextAlign.end,
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                  "7096xxxxxx",
                                  // textAlign: TextAlign.end,
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Divider(
                      thickness: 3.0,
                      color: Colors.white,
                    )
                  ]),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  title: Text("My product",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  title: Text("T&C",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.delivery_dining,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  title: Text("F&Q",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    });
                  },
                  child: Container(
                    height: 50.0,
                    width: 100.0,
                    color: const Color.fromRGBO(255, 255, 255, 0.6),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Log Out",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        color: Color.fromRGBO(21, 107, 191, 1),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                height: 40.0,
                                width: 38.0,
                                child: Image.asset("images/forward.png",
                                    fit: BoxFit.cover),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    height: 45.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey[300]),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        if (value.length > 0) {
                          if (!value.toLowerCase().contains("add")) {
                            searchedSocieties = societies
                                .where((element) => element.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();

                            setState(() {});
                          } else {
                            searchedSocieties = [];
                          }
                        } else {
                          searchedSocieties = [];

                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, bottom: 12.0),
            child: Text(
              "Society(s)",
              style: TextStyle(
                  fontSize: 22.0.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 5.0, top: 5.0),
            child: GridView.builder(
              itemCount: searchedSocieties.length > 0
                  ? searchedSocieties.length
                  : societies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0),
              itemBuilder: (BuildContext context, int index) {
                Society society = societies[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new UserDetail(
                                  society: searchedSocieties.length > 0
                                      ? searchedSocieties[index]
                                      : societies[index],
                                  societies: societies,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
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
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        searchedSocieties.length > 0
                            ? searchedSocieties[index].name
                            : societies[index].name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ))
        ])));
  }
}
