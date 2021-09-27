import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jsdd_deliveryboy/screen/home.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP extends StatefulWidget {
  final String phone;

  const OTP({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? _verificationCode = null;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(300, 800),
        orientation: Orientation.portrait);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 160.0.h,
              width: 160.0.h,
              margin: const EdgeInsets.only(top: 70.0),
              child: Image.asset("images/lock.png")),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Authenticate Your Account",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "We have sent the code verification\nto your Mobile No.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 90.0,
            width: 50.0,
            color: Colors.white,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            child: PinPut(
              textStyle: TextStyle(
                color: Colors.white
              ),
              fieldsCount: 6,
              onSubmit: (String pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode!, smsCode: pin))
                      .then((value) => {
                            if (value.user != null)
                              {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false)
                              }
                          });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState!
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
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
              selectedFieldDecoration: _pinPutDecoration.copyWith(
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
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.shade300,
                border: Border.all(
                  color: Color.fromRGBO(2, 179, 232, 1),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // print('user logged in');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120),
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _verificationCode = verificationId;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
