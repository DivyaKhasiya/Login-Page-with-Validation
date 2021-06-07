import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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

  void validate() {
    SnackBar snackBar;
    if (formKey.currentState.validate()) {
      snackBar=SnackBar(content: Text('Reset Password'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Successfully');
    } else {
      snackBar=SnackBar(content: Text('Enter valid password'),);
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
        padding: EdgeInsets.only(
          top: 100,
          left: 30,
          right: 30,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidate: true,
            child: Column(
              children: [
                Text('Forgot password',
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password',
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
                            showPassword = !showPassword;
                          });
                        },
                      )),
                  controller: passwordTextController,
                  obscureText: showPassword,
                  validator: MultiValidator([
                    RequiredValidator(errorText: '* Required'),
                    MinLengthValidator(8, errorText: 'Minimum 8 Character'),
                    PatternValidator(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
                        errorText: 'Enter Valid Password')
                  ]),
                  focusNode: passFocusNode,
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(passFocusNode);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
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
                  height: 50,
                ),
                FlatButton(
                  onPressed: validate,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFFe1e5ea), Color(0xFFa7bbc7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
