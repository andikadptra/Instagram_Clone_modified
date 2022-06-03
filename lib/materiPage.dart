import 'package:bimbingan_konseling/homePage.dart';
import 'package:flutter/material.dart';
import 'package:bimbingan_konseling/main.dart';

class materiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScrollController _controllerScroll = ScrollController();

    return Scaffold(
        // backgroundColor: Colors.blue,
        // extendBodyBehindAppBar: true,

        body: Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Container(
              child: Image(image: AssetImage('assets/bg.jpg')),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              
            Navigator.pushNamed(context, '/homePage');
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.blue,
          ),
        )
      ],
    ));
  }
}
