part of flunama;

abstract class Overlay {
  dynamic toJSON();
}

// PolylineOptions is used as parameter for functions
// usually returned as Polyline
class PolylineOptions implements Overlay {
  final List<Coordinate> coordinates;
  int color;
  double width;

  PolylineOptions(this.coordinates);

  dynamic toJSON() {
    var t = <dynamic>[];
    coordinates.forEach((Coordinate c) {
      t.add(c.toJSON());
    });
    return t;
  }
}

// Polyline is a geometry feature with an unclosed list of coordinates drawn as a line
// IMPORTANT: Updating an instance of a Polyline does NOT update the map
class Polyline implements Overlay {
  List<Coordinate> coordinates = new List<Coordinate>();
  int color;
  double width;

  Polyline(this.coordinates);

  // Polyline.fromJSON(..) is for cases when you have to get a polyline from JSON
  Polyline.fromJSON(dynamic source) {
    Map<dynamic, dynamic> out = new Map<dynamic, dynamic>.from(source);

    var coords = <dynamic>[];
    coords = out["coordinates"];
    for (var i = 0; i < coords.length; i++) {
      this.coordinates.add(Coordinate.fromJSON(coords[i]));
    }

    this.color = out["color"];
    this.width = out["width"];
  }

  // toJSON() returns a Map<String, dynamic> with the exported Polyline
  dynamic toJSON() {
    Map<String, dynamic> out = <String, dynamic>{};

    var coords = <dynamic>[];
    coordinates.forEach((Coordinate c) {
      coords.add(c.toJSON());
    });

    out["coordinates"] = coords;
    out["color"] = this.color;
    out["width"] = this.width;
    return out;
  }

  String toString(){
    return this.color.toString();
  }
}