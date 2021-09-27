import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../classes.dart';
import 'calendar.dart';

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

  String? ChangedSocietyName;

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
  Widget build(BuildContext mainContext) {
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          society.name,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w300)),
                        )
                      ]),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1 + 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Users",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Total Number of user: ${users.length}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: users.length,
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          SUser user = users[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(mainContext).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Calendar(
                                            user: user,
                                            society: society,
                                          )));
                            },
                            child: Row(children: [
                              Expanded(
                                child: Card(
                                  elevation: 5.0,
                                  margin: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 25.0,
                                        bottom: 25.0,
                                        left: 15.0,
                                        right: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        gradient: (index % 2 == 0)
                                            ? const LinearGradient(
                                                colors: [
                                                  const Color(0xFF02B3E8),
                                                  const Color(0xFF1A55B3),
                                                ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color(0XFFFFFFFF),
                                                  Color(0xFFFFFFFF)
                                                ],
                                                begin:
                                                    FractionalOffset(0.0, 0.0),
                                                end: FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user.Name,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: (index % 2 == 0)
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    2, 179, 232, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, SUser user, int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        await societyReference
            .doc(society.d_id)
            .collection("Users")
            .doc(user.d_id)
            .delete()
            .then((_) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(user.Phone)
              .delete()
              .then((value) {
            Toast.show("DELETED", context, gravity: Toast.BOTTOM);
            Navigator.of(context).pop();
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete User?"),
      content: Text("Deleting User Will Delete All Of It's Data."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
