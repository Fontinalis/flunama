#import <Flutter/Flutter.h>
#import <Mapbox/Mapbox.h>
#import "MapboxOptions.h"

@protocol FLTMapBoxOptionsSink
- (CLLocationCoordinate2D)toLocation:(BOOL)enabled;
@end

@interface FLTMapBoxController
    : NSObject <MGLMapViewDelegate, FlutterPlatformView>
- (_Nullable instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar;
@end

@interface FLTMapBoxFactory : NSObject <FlutterPlatformViewFactory>
- (_Nullable instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>* _Nonnull)registrar;
@end
