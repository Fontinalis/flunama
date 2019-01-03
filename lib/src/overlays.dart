part of flunama;

abstract class Overlay {
  dynamic toJSON();
}

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