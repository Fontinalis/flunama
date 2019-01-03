part of flunama;

class Coordinate {
  double latitude;
  double longitude;

  Coordinate(this.latitude, this.longitude);

  dynamic toJSON() {
    return <double>[latitude, longitude];
  }
}