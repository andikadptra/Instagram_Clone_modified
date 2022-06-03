import 'dart:io';
import 'dart:ui';
import 'package:bimbingan_konseling/drawSide.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class homePage extends StatefulWidget {
  const homePage({Key key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // int noMateri;

  // _homePageState(this.noMateri);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/assistant.png',
      'assets/consult.png',
      'assets/read.png',
      'assets/teaching.png',
      'assets/watch.png'
    ];

    var slidePosiion;

    final judul = ['Chat', 'Konsultasi', 'Baca', 'materi', 'Video'];

    openwhatsapp() async {
      var whatsapp = "+6283844456295"; // Harus Akun bisnis
      var whatsappURl_android =
          "whatsapp://send?phone=" + whatsapp + "&text=hello";
      var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURL_ios)) {
          await launch(whatappURL_ios);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("whatsapp no installed")));
        }
      } else {
        // android , web
        if (await canLaunch(whatsappURl_android)) {
          await launch(whatsappURl_android);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("whatsapp no installed")));
        }
      }
    }

    Future<void> openURL(String url,
        {bool forceWebView = false, bool enableJavaScript = false}) async {
      await launch(url,
          forceWebView: forceWebView, enableJavaScript: enableJavaScript);
    }

    void slideControl() {
      switch (slidePosiion) {
        case 0:
          openwhatsapp();
          break;
        case 1:
          openwhatsapp();
          // setState(() {
          //   openWA('https://wa.me/089614128055?text=hello saya ingin konsultasi',
          //   forceWebView: true,
          //   enableJavaScript: true
          //   );
          // });
          break;
        case 2:
          setState(() {
            Navigator.pushNamed(context, 'materi');
          });
          break;
        case 3:
          setState(() {
            Navigator.pushNamed(context, 'materi');
          });
          break;
        case 4:
          setState(() {
            Navigator.pushNamed(context, 'videoPage');
          });
          break;
        default:
      }
    }

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      slidePosiion = imgList.indexOf(item);
                      print(slidePosiion);
                      slideControl();
                    },
                    child: Card(
                        elevation: 20,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Stack(
                          children: <Widget>[
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFFB1BCE6),
                              ),
                              child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                width: 1000,
                              ),
                            ),
                            //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  '${judul[imgList.indexOf(item)]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )),
            ))
        .toList();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;

    final CarouselController _controller = CarouselController();

    String nameCard;

    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // to home page
        //     print('home button');
        //   },
        //   child: Icon(
        //     Icons.home_rounded,
        //     color: Colors.white,
        //   ),
        //   elevation: 10,
        // ),
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ), // background
        Stack(
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/banner.jpg',
                height: 300,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage('assets/background.jpg'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                // color: Color(0XFF71DFE7),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF205375),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Container(
                                            child: Container(
                                          child: CarouselSlider(
                                              items: imageSliders,
                                              carouselController: _controller,
                                              options: CarouselOptions(
                                                autoPlay: true,
                                                enlargeCenterPage: true,
                                                aspectRatio: 2.0,
                                              )),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 20,
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Color(0xFF947EC3),
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              30,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  'Latihan Soal',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        ButtonTheme(
                                          buttonColor: Colors.white,
                                          height: 50,
                                          minWidth: MediaQuery.of(context)
                                                .size
                                                .width -
                                            30,
                                          child: RaisedButton(
                                            onPressed: () {
                                              openURL('https://forms.gle/9di1ys5awYgJkCAq7');
                                            },
                                            child: Text('Mulai'),)
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF947EC3),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Center(
                                      child: Text(
                                    'About Us',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                                  SizedBox(height: 15),
                                  Text(
                                    'Bimbingan Konseling yang biasanya disingkat dengan BK bisa dibilang memiliki fungsi dan peranan mirip dengan psikolog dimana siswa bisa berkeluh kesah maupun melakukan konsultasi kepada gurunya. Guru BK juga akan membantu siswa untuk menemukan potensi, minat, bakat serta jurusan yang tepat saat kuliah nanti.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 15)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), // bottom appbar
      ],
    ));
  }
}
