part of flunama;

typedef void onTapCallback(Coordinate coord);

class MapboxOptions {
  String styleURL = Style.streets;
  Coordinate centerCoordinate = Coordinate(0, 0);
  double zoomLevel = 1;
  String accessToken;

  MapboxOptions(
    @required this.accessToken,
    {
      String styleURL, 
      Coordinate centerCoordinate,
      double zoomLevel
    }) {
      if (styleURL != null) { 
        this.styleURL = styleURL;
      }
      if (centerCoordinate != null) {
        this.centerCoordinate = centerCoordinate;
      }
      if (zoomLevel != null) {
        this.zoomLevel = zoomLevel;
      }
    }

   Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        optionsMap[fieldName] = value;
      }
    }

    addIfNonNull('styleURL', styleURL);
    addIfNonNull('centerCoordinate', centerCoordinate.toJSON());
    addIfNonNull('zoomLevel', zoomLevel);
    addIfNonNull('accessToken', accessToken);
    return optionsMap;
  }
}

class Style {
  static final String streets = "mapbox://styles/mapbox/streets-v10";
  static final String outdoors = "mapbox://styles/mapbox/outdoors-v10";
  static final String light = "mapbox://styles/mapbox/light-v9";
  static final String dark = "mapbox://styles/mapbox/dark-v9";
  static final String satellite = "mapbox://styles/mapbox/satellite-v9";
  static final String satelliteStreets =
      "mapbox://styles/mapbox/satellite-streets-v10";
  static final String trafficDay = "mapbox://styles/mapbox/traffic-day-v2";
  static final String trafficNight = "mapbox://styles/mapbox/traffic-night-v2";
}