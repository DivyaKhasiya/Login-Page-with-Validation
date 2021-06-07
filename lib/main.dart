import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginpage_with_validation/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.ptSerif().fontFamily,
          accentColor: Colors.black54,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              headline2: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              headline3: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey[400],
                  fontWeight: FontWeight.bold),
              headline4: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
