part of flunama;

typedef void MapCreatedCallback(MapBoxController controller);

class MapBox extends StatefulWidget {
  MapBox({
    @required this.onMapCreated,
    this.gestureRecognizers,
    this.options,
  }) {
    if (options == null) {
      options = MapboxOptions(
        styleURL: Style.streets,
        centerCoordinate: Coordinate(0, 0),
        zoomLevel: 1.0,
      );
    }
  }

  final MapCreatedCallback onMapCreated;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  
  MapboxOptions options;

  @override
  State createState() => _MapBoxState(options);
}

class _MapBoxState extends State<MapBox> {
  MapboxOptions mapboxOptions;

  _MapBoxState(this.mapboxOptions);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'barna.io/mapbox',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: <String, dynamic>{
          'options': mapboxOptions.toMap(),
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'barna.io/mapbox',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: <String, dynamic>{
          'options': mapboxOptions.toMap(),
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    final MapBoxController controller =
        await MapBoxController.init(id);
    widget.onMapCreated(controller);
  }
}