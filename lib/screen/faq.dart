// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatefulWidget {
  FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

bool isExpand = false;

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
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
            )),
            title: Text("FAQ'S"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "images/back.png",
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Advantages of our applications',
                  style: GoogleFonts.roboto(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900]),
                ),
              ),
              subtitle: Text(
                '1. Ensures quick delivery of milk to the users.\n2. Easy to operate UI.\n3. Assists the user to keep track of their monthly expenses.\n4.Provides fluent and impregnable online transactions.\n5. Admins can access real-time location feed of users society and monitor their delivery status.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800]),
              ),
            ),
            FQ(
                title: "6. Is 24x7 Customer Support Available?",
                subtitle:
                    "Catering to your needs is a must at our Jan Shakti Dudh depo and we are available 24x7 for you."),
            FQ(
                title: "7. What type of milk do you guys supply?",
                subtitle:
                    "We at Jan Shakti Dudh depo deliver highly pasteurized, adulteration free organic milk rich in vitamin and antioxidant properties"),
            FQ(
                title: "8. Can we keep track of our daily deliveries?",
                subtitle:
                    "Yes, we have a calendar interface that indicates whether your products were delivered to your doorstep or not so that the user can keep track of their deliveries."),
            FQ(
                title: "9. What are the modes of payment accepted?",
                subtitle:
                    "We accept all modes of payment:– Online payment- NEFT, BHIM UPI, Online payment using CC/DC/Net banking, Paytm, etc- you can use our Mobile App to use the above payment gateways"),
            FQ(
                title: "10. Why should one install your app?",
                subtitle:
                    "The app is designed to ensure consumer convenience as well as to eliminate the paperwork that every consumer must maintain every month for milk.")
          ]),
        ));
  }
}

class FQ extends StatelessWidget {
  final String title;
  final String subtitle;
  const FQ({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey[900]),
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[800]),
      ),
    );
  }
}
