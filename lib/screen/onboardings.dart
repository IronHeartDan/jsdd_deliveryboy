// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jsdd_deliveryboy/screen/login.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentState = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: [
            Stack(fit: StackFit.expand, children: [
              Image.asset(
                "images/first.png",
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5,
                          left: 0.0),
                      child: Text("Quality customer service",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ))),
                  Container(
                      margin: EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: Text(
                          "Experience top-notch customer service on our app\n by retaining your data which will be utilized\n to ensure timely accurate deliveries",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "SKIP",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]),
            Stack(fit: StackFit.expand, children: [
              Image.asset(
                "images/second.png",
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5,
                          left: 0.0),
                      child: Text("100% Organic milk",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Text(
                          "The absence of preservation in our 100% organic milk enriches its omega 3 fatty acid properties, which in\n return stimulates your fat loss, helps in controlling \n heart disease, and even lower your blood pressure\n to aid you keeping a healthy lifestyle",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w300,
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "SKIP",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]),
            Stack(fit: StackFit.expand, children: [
              Image.asset(
                "images/third.png",
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5,
                          left: 20.0),
                      child: Text("Unbreachable Privacy & Security",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ))),
                  Container(
                      margin: EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: Text(
                          "Rest assured your data is in safe hands locked\n behind our OTP verification vault to maximize\n your privacy and security",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "SKIP",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
            Stack(fit: StackFit.expand, children: [
              Image.asset("images/fourth.png", fit: BoxFit.cover),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: 0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            "Doorstep delivery within 24 hours of milking ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Text(
                          "Enjoy fresh milk and a variety of dairy products\n delivered straight to your footsteps/doorsteps\n with flexible ordering, get fresh products\n within 24 hours of milking",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ))),
                ],
              ),
            ]),
          ],
          done: Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Image.asset("images/forward.png"),
          ),
          skip: Text(
            "Skip",
            style: TextStyle(color: Colors.white),
          ),
          onDone: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          onSkip: () {},
          showSkipButton: false,
          showDoneButton: true,
          showNextButton: false,
          next: Text(
            "Next",
            style: TextStyle(color: Colors.white),
          ),
          onChange: (index) {
            currentState = index;
            setState(() {});
          },
          dotsDecorator: DotsDecorator(
              color: currentState == 3
                  ? Colors.blueAccent
                  : currentState == 2
                      ? Colors.white
                      : currentState == 0
                          ? Colors.white
                          : Colors.blueAccent,
              activeColor: currentState == 3
                  ? Colors.blueAccent
                  : currentState == 2
                      ? Colors.white
                      : currentState == 0
                          ? Colors.white
                          : Colors.blueAccent,
              size: Size(10, 10),
              activeSize: Size(22, 10),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              )),
        ),
      ),
    );
  }
}
