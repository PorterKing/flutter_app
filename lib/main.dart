// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'package:flutter_app/calculate/CalculatePage.dart';
import 'package:flutter_app/tglj/TGLJListPage.dart';

void main() => runApp(new MaterialApp(
      title: "Hello world",
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Flutter App"),
            centerTitle: true,
            iconTheme: new IconThemeData(color: Colors.white),
          ),
          body: new Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new TGLJButton(),
                new CalculateButton(),
              ],
            ),
            alignment: Alignment.center,
          )),
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
    ));

class TGLJButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
        child: new Container(
          child: new Text(
            "跳转到谈股论金",
            style: new TextStyle(fontSize: 20.0, color: Colors.cyanAccent),
          ),
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          width: 160.0,
          height: 50.0,
          decoration: new BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.lightBlue,
                Colors.greenAccent,
                Colors.purple
              ]),
              borderRadius: const BorderRadius.all(const Radius.circular(8.0))),
        ),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new TGLJListPage()));
        });
  }
}

class CalculateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
        child: new Container(
          child: new Text(
            "跳转到计算器",
            style: new TextStyle(fontSize: 20.0, color: Colors.cyanAccent),
          ),
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          width: 160.0,
          height: 50.0,
          decoration: new BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: const BorderRadius.all(const Radius.circular(8.0))),
        ),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new CalculatePage()));
        });
  }
}
