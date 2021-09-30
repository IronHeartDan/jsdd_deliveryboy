import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
            title: const Text("About Us"),
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
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // title: Text(
              //   'About Us',

              // ),
              subtitle: Text(
                'We at Jan Shakti Dudh Depo believe in only sourcing ethically farmed organic milk, that boosts up your family’s immunity and omega 3 fat percentage, while delivering it fresh within 24 hrs of milking. Our motto is to provide an interactive interface through which you can experience seamless delivery of our products to your doorstep while making sure that your personal info is completely safe and secure.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[800]),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () {
                _launchURLFacebook();
              },
              child: const Icon(
                Icons.facebook,
                color: Colors.blueAccent,
                size: 30.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                primary: Colors.white, // <-- Button color
                onPrimary: Colors.blue, // <-- Splash color
              ),
            ),
            // LinkedIn Button.....
            ElevatedButton(
              onPressed: () {
                _launchURLlinkedin();
              },
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/174/174857.png",
                width: 26.0,
                height: 26.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                primary: Colors.white, // <-- Button color
                onPrimary: Colors.blue, // <-- Splash color
              ),
            ),
            // Instagram Button......
            ElevatedButton(
              onPressed: () {
                _launchURLinsta();
              },
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/2111/2111463.png",
                width: 26.0,
                height: 26.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                primary: Colors.white, // <-- Button color
                onPrimary: Colors.blue, // <-- Splash color
              ),
            ),
          ])
        ]));
  }

  _launchURLinsta() async {
    const url = "https://www.instagram.com/grape_studio_enterprise/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Url is not launch $url';
    }
  }

  _launchURLlinkedin() async {
    const url =
        "https://www.linkedin.com/company/grape-studio-enterprise/mycompany/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Url is not launch $url';
    }
  }

  _launchURLFacebook() async {
    const url = "https://www.facebook.com/Grapestudioenterprise";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Url is not launch $url';
    }
  }
}
