import 'package:bimbingan_konseling/homePage.dart';
import 'package:bimbingan_konseling/materiPage.dart';
import 'package:bimbingan_konseling/sliderPage.dart';
import 'package:bimbingan_konseling/videoPage.dart';
import 'package:bimbingan_konseling/_videoPage.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:bimbingan_konseling/sliderPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homePage': (context) => homePage(),
        'videoPage': (context) => YoutubePage(),
        'introSlider': (context) => sliderPage(),
        'materi': (context) => materiPage(),
      },
      home: sliderPage(),
    );
  }
}
