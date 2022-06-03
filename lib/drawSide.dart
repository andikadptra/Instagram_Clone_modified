import 'package:flutter/material.dart';

class drawSide extends StatelessWidget {
  const drawSide({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.50,
        child: Stack(
          children: [
            Container(
              color: Colors.blue[200]
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
              color: Colors.blue[300]
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  color: Colors.blue,
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: ClipOval(
                            child: Image.network(
                              'https://www.kindacode.com/wp-content/uploads/2020/12/the-cat.jpg',
                              width: MediaQuery.of(context).size.height * 0.30 - 100,
                              height: MediaQuery.of(context).size.height * 0.30 - 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Text(
                              'Andika',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900]
                          ),
                          ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(10),
                        child: Text('data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900]
                          ),
                          ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(10),
                        child: Text('data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900]
                          ),
                          ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}