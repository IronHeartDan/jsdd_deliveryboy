import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:jsdd_deliveryboy/screen/otp.dart';

final firebasefirestore = FirebaseFirestore.instance;
final boyRef = firebasefirestore.collection("deliveryBoy");

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phoneno = null;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              // ignore: prefer_const_constructors
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
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.all(13.0),
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset("images/back.png")),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: const Text(
                        "WELCOME",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: 20.0),
                      child: const Text(
                        "ENTER PHONE NUMBER",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      decoration: InputDecoration(
                        counter: Offstage(),

                        hintText: "7096******",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        hintStyle: const TextStyle(
                            color: Colors.white60, fontSize: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                      controller: _controller,
                      onChanged: (value) {
                        if (value.isNotEmpty && value.length == 10) {
                          setState(() {
                            // _validate = true;
                            phoneno = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) => OTP()));
                            await boyRef.doc(phoneno).get().then((value) {
                              if (value.exists) {
                                print("Founded");
                                logUser();
                              } else {
                                print("Not found");
                              }
                              // ignore: invalid_return_type_for_catch_error
                            }).catchError((value) => {print(value)});
                          },
                          child: const Text(
                            "SEND OTP",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.white))))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void logUser() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OTP(
                  phone: _controller.text,
                )));
  }
}
