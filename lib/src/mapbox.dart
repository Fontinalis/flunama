part of flunama;

typedef void MapCreatedCallback(MapBoxController controller);

class MapBox extends StatefulWidget {
  MapBox({
    @required this.onMapCreated,
    this.gestureRecognizers,
  });

  final MapCreatedCallback onMapCreated;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  String styleURL = Style.streets;
  

  @override
  State createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  final Map<String, dynamic> creationParams = <String, dynamic>{
    'options': MapboxOptions(Style.satellite).toMap(),
  };


  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'barna.io/mapbox',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'barna.io/mapbox',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
//        creationParams: widget.options._toJson(),
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