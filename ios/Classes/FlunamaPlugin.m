#import "FlunamaPlugin.h"
#import "MapboxController.h"

@implementation FlunamaPlugin {
  NSObject<FlutterPluginRegistrar>* _registrar;
  FlutterMethodChannel* _channel;
  NSMutableDictionary* _mapControllers;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FLTMapBoxFactory* mapboxFactory = [[FLTMapBoxFactory alloc] initWithRegistrar:registrar];
  [registrar registerViewFactory:mapboxFactory withId:@"barna.io/mapbox"];
}

- (FLTMapBoxController*)mapFromCall:(FlutterMethodCall*)call error:(FlutterError**)error {
  id mapId = call.arguments[@"map"];
  FLTMapBoxController* controller = _mapControllers[mapId];
  if (!controller && error) {
    *error = [FlutterError errorWithCode:@"unknown_map" message:nil details:mapId];
  }
  return controller;
}
@end
