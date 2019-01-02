import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text("flunama example"),
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
          options: MapboxOptions(
            "pk.eyJ1IjoiZm9udGluYWxpcyIsImEiOiJjamo3N3QxZzkwcGZkM3Jzd3R0OHd3eG9jIn0.MDmSPZyfbQ7NP0toOzSnyg",
            styleURL: Style.satellite,
            centerCoordinate: Coordinate(42, 47),
            zoomLevel: 3.0,
          ),
        ),
      ),
    );
  }
}
