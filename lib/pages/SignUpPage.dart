import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginpage_with_validation/pages/InputDecoration.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPassword = true;
  bool confirmPass = true;

  FocusNode passFocusNode;
  FocusNode confirmFocusNode;

  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passFocusNode = FocusNode();
    confirmFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    passFocusNode.dispose();
    confirmFocusNode.dispose();
  }

  void validate(){
     SnackBar snackBar;
    if (formKey.currentState.validate()) {
      snackBar=SnackBar(content: Text('Submit Successfully'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Successfully');
    } else {
      snackBar=SnackBar(content: Text('Enter valid Details '),);
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
            padding: EdgeInsets.only(top: 50, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidate: true,
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: buildInputDecoration(
                          'Enter Name', Theme.of(context).textTheme.headline2),
                      keyboardType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-z]'))],
                      validator: RequiredValidator(errorText: '*Required'),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: buildInputDecoration(
                          'Phone Number', Theme.of(context).textTheme.headline2),
                      keyboardType: TextInputType.number,
                      validator: MultiValidator([
                        RequiredValidator(errorText: '*Required'),
                        MinLengthValidator(10, errorText: '10 Minimum Number'),
                        MaxLengthValidator(10, errorText: '10 Maximum nmber')
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: buildInputDecoration(
                          'PinCode', Theme.of(context).textTheme.headline2),
                      keyboardType: TextInputType.number,
                      validator: MultiValidator([
                        RequiredValidator(errorText: '*Required'),
                        MaxLengthValidator(6, errorText: 'Maximum 6 number')
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: buildInputDecoration(
                          'Email Id', Theme.of(context).textTheme.headline2),
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: '*Required'),
                        EmailValidator(errorText: 'Enter Valid Email Id')
                      ]),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: Theme.of(context).textTheme.headline2,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                confirmPass = !confirmPass;
                              });
                            },
                          )),
                      obscureText: confirmPass,
                      controller: confirmPasswordTextController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return '*Required';
                        }
                        if (passwordTextController.text != confirmPasswordTextController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                      focusNode: confirmFocusNode,
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(confirmFocusNode);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
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
                          'Submit',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
