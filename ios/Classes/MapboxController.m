#import "MapboxController.h"

#pragma mark - Conversion of JSON-like values sent via platform channels. Forward declarations.

@implementation FLTMapBoxFactory {
  NSObject<FlutterPluginRegistrar>* _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FLTMapBoxController alloc] initWithFrame:frame
                                        viewIdentifier:viewId
                                             arguments:args
                                             registrar:_registrar];
}
@end

@implementation FLTMapBoxController {
    MGLMapView* _mapView;
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    NSObject<FlutterPluginRegistrar>* _registrar;
    MapboxOptions* _options;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar{
    if ([super init]) {
        _viewId = viewId;
        
        NSURL *url = [NSURL URLWithString:@"mapbox://styles/mapbox/streets-v10"];
        _mapView = [[MGLMapView alloc] initWithFrame:frame styleURL:url];
        _options = [[MapboxOptions alloc] init];
        [_options apply:_mapView json:args[@"options"]];
        
        NSString* channelName =
            [NSString stringWithFormat:@"barna.io/mapbox_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName
                                               binaryMessenger:registrar.messenger];
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            if (weakSelf) {
                [weakSelf onMethodCall:call result:result];
            }
        }];
        _mapView.delegate = weakSelf;
        _registrar = registrar;
    }
    return self;
}

- (UIView*)view {
  return _mapView;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"setCenterCoordinate:animated" isEqualToString:call.method]) {
        [_mapView setCenterCoordinate:toLocation(call.arguments[@"location"])
                              animated:toBool(call.arguments[@"animated"])];
        result(@"success");
    } else if ([@"styleURL:set" isEqualToString:call.method]) {
        NSString* urlStr = call.arguments[@"styleURL"];
        NSURL *url = [NSURL URLWithString:urlStr];
        _mapView.styleURL = url;
        result(@"success");
    } else if ([@"styleURL:get" isEqualToString:call.method]) {
        result([_mapView.styleURL absoluteString]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

static double toDouble(id json) {
  NSNumber* data = json;
  return data.doubleValue;
}

static bool toBool(id json) {
  NSNumber* data = json;
  return data.boolValue;
}

static CLLocationCoordinate2D toLocation(id json) {
  NSArray* data = json;
  return CLLocationCoordinate2DMake(toDouble(data[0]), toDouble(data[1]));
}




#pragma mark - MGLMapViewDelegate methods




@end
