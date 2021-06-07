import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginpage_with_validation/pages/InputDecoration.dart';
import 'package:loginpage_with_validation/pages/SignUpPage.dart';
import 'package:loginpage_with_validation/pages/forgotPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPassword = true;
  FocusNode passFocusNode;

  @override
  void initState() {
    super.initState();
    passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    passFocusNode.dispose();
  }

  void validate() {
    SnackBar snackBar;
    if (formKey.currentState.validate()) {
      snackBar=SnackBar(content: Text('Login Successfully'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Successfully');
    } else {
      snackBar=SnackBar(content: Text('Enter valid email&password'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Ink(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/image1.jpg'), fit: BoxFit.fill)),
            padding: EdgeInsets.only(top: 100, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidate: true,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Login Page",
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      decoration: buildInputDecoration('Email',Theme.of(context).textTheme.headline2),
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: '*Require'),
                        EmailValidator(errorText: 'Enter Valid Email Id')
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: showPassword,
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required'),
                        MinLengthValidator(8, errorText: 'Maximum 8 character'),
                        PatternValidator(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
                            errorText: 'Enter valid Password')
                      ]),
                      focusNode: passFocusNode,
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(passFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: Theme.of(context).textTheme.headline2,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ForgotPassword();
                              }));
                            });
                          },
                          child: Text('Forgot Password',
                              style: Theme.of(context).textTheme.headline3)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                      onPressed: validate,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFe1e5ea),
                                Color(0xFFa7bbc7)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        alignment: Alignment.center,
                        height: 40,
                        width: 150,
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I'm a new User",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUpPage();
                                }));
                              });
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
