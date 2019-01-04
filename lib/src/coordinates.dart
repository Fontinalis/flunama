part of flunama;

class Coordinate {
  double latitude;
  double longitude;

  Coordinate(this.latitude, this.longitude);
  
  Coordinate.fromJSON(dynamic source) {
    List<double> out = new List<double>.from(source);
    this.latitude = out[0];
    this.longitude = out[1];
  }

  dynamic toJSON() {
    return <double>[latitude, longitude];
  }
}