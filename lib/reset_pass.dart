import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'otp.dart';
// library email_otp;

class ResetPasswordPage extends StatefulWidget {
  // const ResetPasswordPage({super.key});
  static TextEditingController emailController = TextEditingController();
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  void Verify(String email) async {
    try{
      http.Response response = await http.post(
        Uri.parse('https://vinsupinfotech.com/FMS/public/api/forgot'),
        body: {'email': email},
      );
      if (response.statusCode == 200) {
        print("Verify") ;
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) =>  Otp(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
        // Navigate to the next screen or update UI accordingly
      } else {
        // Login failed, handle errors
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            content: const Text('Enter Valid Email...',style: TextStyle(color: Colors.white,fontSize: 19),),
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
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: Color(0xfff97d7d),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/forgot.png"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Do not worry !  We Will help you recover your password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: ResetPasswordPage.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Enter Your E-mail",
                            suffixIcon: Icon(
                              Icons.email,
                              color: Color(0xfff97d7d),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          style: const TextStyle(fontSize: 20),
                          validator: (value){
                            if(value!.isEmpty){
                              return "* Enter Your Valid Email Id";
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color(0xFFF58524),
                                Color(0XFFF92B7F),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff97d7d),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Verify(ResetPasswordPage.emailController.text.toString());
                                if (_formKey.currentState!.validate()) {
                                   print("Success");
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     pageBuilder: (c, a1, a2) =>  Otp(),
                                  //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  //     transitionDuration: const Duration(milliseconds: 1000),
                                  //   ),
                                  // );
                                }

                              },
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );();
  }
}


