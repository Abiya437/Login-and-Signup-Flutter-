import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginnew/get_otp_res_data.dart';
import 'confirm_pass.dart';
import 'reset_pass.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  // const Otp({Key? key}) : super(key: key);
  static var  userid;
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  void Verify(String email, otp) async {
    try {
      var getotpuri =  Uri.https('www.vinsupinfotech.com','/FMS/public/api/get_otp', {'email': email, 'otp': otp});
      debugPrint("${getotpuri}");
      http.Response response = await http.post(
        getotpuri
      );
      debugPrint("${response.body}");
      if (jsonDecode(response.body) == "OTP Invalid"){
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.teal,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            content:  Text('Enter Valid Otp',style: TextStyle(color: Colors.white,fontSize: 19),),
            action: SnackBarAction(
              label: 'Ok',
              textColor: Colors.yellow,
              onPressed: () {},
            ),
          ),
        );
      } else {
        try{
          var jsonDecodeResponse = jsonDecode(response.body);
          GetOtpResData getOtpResData = GetOtpResData.fromJson(jsonDecodeResponse);
         Otp.userid=getOtpResData.details?.userId;
          if(getOtpResData.status == 'OTP Valid'){
            print("Otp Verifyed");
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) =>  ConfirmPasswordPage(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );
            // var dialog = showDialog(
            //   context: context,
            //   builder: (ctx) => AlertDialog(
            //     title: const Text("Alert"),
            //     content:  Text("Your User Id is  $userid"),
            //     actions: <Widget>[
            //       TextButton(
            //         onPressed: () {
            //           },
            //         child: Container(
            //           // color: Colors.green,
            //           padding: const EdgeInsets.all(14),
            //           child: const Text("okay"),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => ConfirmPasswordPage(),
            //   ),
            // );

          }
        }catch(e){
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Image.asset(
                  'assets/ot.jpg',
                  width: 400,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your 6 digit OTP number",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(context, otpController1),
                          _textFieldOTP(context, otpController2),
                          _textFieldOTP(context, otpController3),
                          _textFieldOTP(context, otpController4),
                          _textFieldOTP(context, otpController5),
                          _textFieldOTP(context, otpController6)
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          color: const Color(0xfff97d7d),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          child: const Text(
                            'Verify',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {

                            if (otpController1.text.isEmpty ||
                                otpController2.text.isEmpty ||
                                otpController3.text.isEmpty ||
                                otpController4.text.isEmpty ||
                                otpController5.text.isEmpty ||
                                otpController6.text.isEmpty)
                            {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Alert",
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold)),
                                  content: const Text("Enter OTP"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        // color: Colors.green,
                                        height: 70,
                                        width: 100,
                                        padding: EdgeInsets.all(14),
                                        child: const Text(
                                          "okay",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              print('Enter otp');
                            }
                            else {
                              final otp = (otpController1.text +
                                  otpController2.text +
                                  otpController3.text +
                                  otpController4.text +
                                  otpController5.text +
                                  otpController6.text);
                              Verify(
                                  ResetPasswordPage.emailController.text
                                      .toString(),
                                  otp.toString());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // {bool? first, last}
  Widget _textFieldOTP(BuildContext context, TextEditingController controller) {
    return Container(
      width: 45,
      height: 70,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
           controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.text,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Color(0xfff97d7d)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
//
// void show_Simple_Snackbar(BuildContext context) {
//   Flushbar(
//     duration: Duration(seconds: 3),
//     message: "Enter Your Otp",
//   )..show(context);
// }
