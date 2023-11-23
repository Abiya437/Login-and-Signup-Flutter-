import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
   const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isActive = false;
  bool _isSecuredPassword = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CpasswordController = TextEditingController();

  void Register(String name, email, password, c_password) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/register'),
          body: {
            'name': name,
            'email': email,
            'password': password,
            'c_password': c_password
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Registeration successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  // @override
  // void dispose() {
  //   SignUpPage.emailController.dispose();
  //   SignUpPage.passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'assets/sign_up.png',
                  width: 260,
                  height: 220,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 34,
                ),
                const Text(
                  'Sign up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller:nameController ,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Color(0xfff97d7d), fontSize: 15),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xfff97d7d),
                      size: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter Your Name";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller:emailController ,

                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    labelStyle: TextStyle(color: Color(0xfff97d7d), fontSize: 15),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xfff97d7d),
                      size: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
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
                  controller:passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xfff97d7d), fontSize: 15),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color(0xfff97d7d),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "* Enter Your Password ";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: CpasswordController,
                  obscureText: _isSecuredPassword,
                  decoration: InputDecoration(
                    prefixIcon:const Icon(
                        Icons.lock,
                        color:  Color(0xfff97d7d)
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isSecuredPassword = !_isSecuredPassword;
                          });
                        },
                        icon: Icon(_isSecuredPassword
                            ? Icons.visibility_off
                            : Icons.visibility,color:  Colors.grey)),
                    labelText: 'Confirm password',
                    labelStyle: const TextStyle(color:  Color(0xfff97d7d), fontSize: 15),
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
                      return "* Please Enter Your Confirm Password";
                    }else{
                      return null;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (value) => setState(() {
                        isActive = value!;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        'I agree whit the terms and conditions\nand privacy policy',
                        style: TextStyle(color: Colors.grey[500] , fontSize: 13),
                      ),
                    ),],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: MaterialButton(
                    color: const Color(0xfff97d7d),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    onPressed: () {
                      Register(
                          nameController.text.toString(),
                          emailController.text.toString(),
                          passwordController.text.toString(),
                          CpasswordController.text.toString());
                      if (_formKey.currentState!.validate()) {
                        print("submited");
                      }
                      String password =passwordController.text;
                      String CPassword =  CpasswordController.text;
                      if (password == CPassword) {
                        print('Passwords match');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.teal,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            content: const Text('Sign Up Successfully....',
                              style: TextStyle(color: Colors.white,fontSize: 19),),
                            action: SnackBarAction(
                              label: 'Next',
                              textColor: Colors.yellow,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>  const LoginUiPage(),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: const Duration(milliseconds: 1000),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        print('Passwords do not match');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            shape: StadiumBorder(),
                            content: const Text('Your Password Missmatch. Please enter Correct Password!',
                              style: TextStyle(color: Colors.white,fontSize: 19),),
                            action: SnackBarAction(
                              label: 'ok',
                              textColor: Colors.yellow,
                              onPressed: () {
                                // Code to execute.
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Already Have  an account? ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => const LoginUiPage(),
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
                // const SizedBox(
                //   height: 50,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}