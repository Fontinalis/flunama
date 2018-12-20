import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flunama/flunama.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MapBoxController controller;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(MapBoxController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "asd",
      home: Scaffold(
        appBar: AppBar(
          title: Text("MapBox on iOS"),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.gps_fixed),
              onPressed: () {
                controller.setCenterCoordinate(Coordinate(47.5, 19.05), true);
                controller.getStyleURL().then((url) {
                  debugPrint(url);
                });
                controller.setStyleURL(Style.satelliteStreets);
              },
            )
          ],
        ),
        body: MapBox(
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
