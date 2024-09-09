import 'package:flutter/material.dart';
import 'package:implementation/pages/assessment_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intrapartum Application',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3DCE9)),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF9F9),
          title: Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'INTRAPARTUM',
              style: TextStyle(
                color: Color(0xFF1D1936),
                fontSize: 28,
                fontWeight: FontWeight.w800,
                fontFamily: 'OpenSansCondensed'
              ))
          ),
        ),
        body: AssessmentPage(),
      )
    );
  }
}


