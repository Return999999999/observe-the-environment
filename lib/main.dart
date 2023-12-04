import 'package:flutter/material.dart';
import 'package:luanvan/page/mainpage/Notifications.dart';
import 'package:luanvan/page/mainpage/Setting.dart';
import 'package:luanvan/page/quantrac/Charts.dart';
import 'package:luanvan/page/quantrac/Home.dart';
import 'package:luanvan/page/mainpage/HomePage.dart';
import 'package:luanvan/page/Login.dart';
import 'package:luanvan/page/quantrac/Location.dart';
import 'package:luanvan/page/quantrac/Map.dart';
import 'package:luanvan/page/quantrac/Setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quan Trắc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/homepage': (
          context,
        ) =>
            const HomePage(),
        '/Notifications': (context) => const Notifications(),
        '/Settings': (context) => const Settings(),
        '/homepage/home': (context) => const Home(),
        '/homepage/home/map': (context) => const Map(),
        '/homepage/home/location': (context) => const Location(),
        '/homepage/home/charts': (context) => const Charts(),
        '/homepage/home/setting': (context) => const Setting(),
      },
    );
  }
}
