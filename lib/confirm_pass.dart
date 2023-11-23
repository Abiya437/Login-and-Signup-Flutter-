import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'otp.dart';

class ConfirmPasswordPage extends StatefulWidget {
  @override
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}
class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSecuredPassword = true;
  bool _isSecuredPassword2 = true;
  late TextEditingController _useridController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  void Verify(String user_id,password) async {
    try{
      http.Response response = await http.post(
        Uri.parse('https://vinsupinfotech.com/FMS/public/api/change_password'),
        body: {'user_id': user_id,'password': password },
      );
      if(response.statusCode == 200){
        print('Password Changed Successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              content: const Text('Your Password has been Changed...',style: TextStyle(color: Colors.white,fontSize: 19),),
              action: SnackBarAction(
                label: 'Next',
                textColor: Colors.yellow,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) =>  LoginUiPage(),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),
          );
      }
      else {
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.greenAccent,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            content: const Text('Please Check Your User ID',style: TextStyle(color: Colors.white,fontSize: 19),),
            action: SnackBarAction(
              label: 'Ok',
              textColor: Colors.yellow,
              onPressed: () {},
            ),
          ),
        );
      }
    }
    catch(e){
      print(e.toString());
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _useridController = new TextEditingController(text: Otp.userid.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Password'),
        centerTitle: true,
        backgroundColor: Color(0xfff97d7d),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Image.asset(
                    'assets/confirm.png', // Add your lock icon asset
                    // height: 100.0,
                    // color: Theme.of(context).primaryColor,
                    width: 400,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                ),
                TextFormField(
                  controller: _useridController,
                  autovalidateMode: AutovalidateMode.always,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'User ID',
                    labelStyle: TextStyle(color: Color(0xfff97d7d), fontSize: 15),
                    prefixIcon: Icon(
                      Icons.person,
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

                ),
                SizedBox(
                  height: 14.0,
                ),
                // _buildPasswordTextField('Password', _passwordController),

                SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
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
                labelText:' Password',
                labelStyle: TextStyle(color:  Color(0xfff97d7d), fontSize: 17),
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
                  return "* Please Enter Your Password";
                }else{
                  return null;
                }
              },
            ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isSecuredPassword2,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isSecuredPassword2 = !_isSecuredPassword2;
                          });
                        },
                        icon: Icon(_isSecuredPassword2
                            ? Icons.visibility_off
                            : Icons.visibility,color: Colors.purple ,)),
                    labelText:' Confirm Password',
                    labelStyle: TextStyle(color:  Color(0xfff97d7d), fontSize: 17),
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
                SizedBox(height: 24.0),
                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()){
          if (_passwordController.text !=
              _confirmPasswordController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                shape: StadiumBorder(),
                content: const Text(
                  'Password Missmatch. Please enter Correct Password!',
                  style: TextStyle(color: Colors.white, fontSize: 19),),
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
          else{
            Verify(_useridController.text.toString(), _passwordController.text.toString());
          }
        }

        },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        backgroundColor: const Color(0xfff97d7d),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'Reset Password',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
