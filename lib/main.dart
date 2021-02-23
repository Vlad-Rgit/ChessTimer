import 'package:chess_timer/di.dart';
import 'package:chess_timer/screens/home_screen/home_screen.dart';
import 'package:chess_timer/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  registerDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ChessTimerTheme.themeData,
      home: HomeScreen(),
    );
  }
}
