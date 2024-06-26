import 'package:covid_19_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
