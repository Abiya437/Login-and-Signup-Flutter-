import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginnew/reset_pass.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class LoginUiPage extends StatefulWidget {
  const LoginUiPage({super.key});

  @override
  State<LoginUiPage> createState() => _LoginUiPageState();
}

class _LoginUiPageState extends State<LoginUiPage> {
  bool _isSecuredPassword = true;
  // String a = new String("St");
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void login(String email , password) async {
    try{
      http.Response response = await http.post(
        Uri.parse('https://vinsupinfotech.com/FMS/public/api/login'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        // print("Login successful") ;
        // Navigate to the next screen or update UI accordingly
        // ignore: use_build_context_synchronously
        var dialog = showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Alert"),
            content: const Text("Login Successfully.."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) =>  SignUpPage(),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
        );
      }
      else {
        // Login failed, handle errors
        // print('failed');
        // ignore: use_build_context_synchronously
        var dialog = showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Alert"),
            content: const Text("Please check Your email and password"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                ),
                Image.asset(
                  'assets/welcome_image_login.png',
                  width: 260,
                  height: 220,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 34,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    labelStyle: TextStyle(color: Color(0xfff97d7d), fontSize: 15),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.purple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: _isSecuredPassword,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isSecuredPassword = !_isSecuredPassword;
                          });
                        },
                        icon: Icon(_isSecuredPassword
                            ? Icons.visibility_off
                            : Icons.visibility,color: Colors.purple ,)),
                    labelText: 'password',
                    labelStyle: TextStyle(color:  Color(0xfff97d7d), fontSize: 15),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Your Password";
                    }else{
                      return null;
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) =>  ResetPasswordPage(),
                          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                          transitionDuration: const Duration(milliseconds: 1000),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xfff97d7d),fontSize: 17.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: MaterialButton(
                    color: const Color(0xfff97d7d),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      login(emailController.text.toString(), passwordController.text.toString());
                      if (_formKey.currentState!.validate()) {
                      }
                      },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),

                // const SizedBox(
                //   height: 15,
                // ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Don't Have  an account? ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) =>  SignUpPage(),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: const Duration(milliseconds: 1000),
                          ),
                        );
                      },
                      style: const TextStyle(
                          color: Color(0xffee0f37),
                          fontWeight: FontWeight.w700,
                          fontSize: 19
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



