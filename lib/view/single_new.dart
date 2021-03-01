import 'package:flutter/material.dart';

class SingleNew extends StatefulWidget {
  SingleNew({Key key}) : super(key: key);

  @override
  _SingleNewState createState() => _SingleNewState();
}

class _SingleNewState extends State<SingleNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //===========================BARRA SUPERIOR===============================
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => print('return...'),
            );
          },
        ),
        title: Text(
          'BIT News',
          style: TextStyle(color: Colors.black26),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.favorite),
            ),
          )
        ],
        //======================================================================
      ),
      //========================================================================
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(),
      ),
    );
  }
}
