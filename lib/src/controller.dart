part of flunama;

/// Controller for a single GoogleMap instance running on the host platform.
///
/// Change listeners are notified upon changes to any of
///
/// * the [options] property
/// * the collection of [Marker]s added to this map
/// * the [isCameraMoving] property
/// * the [cameraPosition] property
///
/// Listeners are notified after changes have been applied on the platform side.
///
/// Marker tap events can be received by adding callbacks to [onMarkerTapped].
class MapBoxController extends ChangeNotifier {
  MapBoxController._(
      this._id, 
      MethodChannel channel,
      )
      : assert(_id != null),
        assert(channel != null),
        _channel = channel {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static Future<MapBoxController> init(
      int id) async {
    assert(id != null);
    final MethodChannel channel =
        MethodChannel('barna.io/mapbox_$id');
    return MapBoxController._(id, channel);
  }

  final MethodChannel _channel;
  final int _id;

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "setCenterCoordinate:animated":
        
        break;
      default:
        throw MissingPluginException();
    }
  }

  Future<Null> setCenterCoordinate(Coordinate coordinate, bool animated) async {
    try {
      await _channel.invokeMethod(
        'setCenterCoordinate:animated',
        <String, Object>{
          'location': coordinate.toJSON(),
          'animated': animated,
        },
      );
    } on PlatformException catch (e) {
      return new Future.error(e);
    }
  }

  Future<Null> setStyleURL(String styleURL) async {
    try {
      await _channel.invokeMethod(
        'styleURL:set',
        <String, Object>{
          'styleURL': styleURL,
        },
      );
    } on PlatformException catch (e) {
      return new Future.error(e);
    }
  }

  Future<String> getStyleURL() async {
    try {
      final String styleURL = await _channel.invokeMethod(
        'styleURL:get',
        <String, Object>{},
      );
      return styleURL;
    } on PlatformException catch (e) {
      return new Future.error(e);
    }
  }
}