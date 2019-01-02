//
//  MapboxOptions.m
//  flunama
//
//  Created by Barnabas Pataki on 2018. 12. 25..
//
#import "MapboxOptions.h"

@implementation MapboxOptions {
    NSURL* styleURL;
    CLLocationCoordinate2D* centerCoordinate;
    double zoomLevel;
}

- (instancetype)init {
    return self;
}

- (void)parse:(id) json {
    NSDictionary* data = json;
//    styleURL check
    id _styleURL = data[@"styleURL"];
    if(_styleURL) {
        NSString* _styleURLStr = _styleURL;
        styleURL = [NSURL URLWithString:_styleURLStr];
    }
//    centerCoordinate check
    id _centerCoordinate = data[@"centerCoordinate"];
    if(_centerCoordinate) {
        centerCoordinate = toLocation(_centerCoordinate);
    }
//    zoom check
    id _zoomLevel = data[@"zoomLevel"];
    if(_zoomLevel) {
        zoomLevel = toDouble(_zoomLevel);
    }

//    accessToken check
    id _accessTokenRaw = data[@"accessToken"];
    if(_accessTokenRaw) {
        NSString* _accessToken = _accessTokenRaw;
        [MGLAccountManager setAccessToken:_accessToken];
    }
}

- (void)apply:(MGLMapView*)_view json:(id)json {
    [self parse:json];
    
    if(styleURL) {
        [_view setStyleURL:styleURL];
    }
    
    if(centerCoordinate) {
        [_view setCenterCoordinate:*centerCoordinate];
    }

    if(zoomLevel) {
        [_view setZoomLevel:zoomLevel];
    }
}

static double toDouble(id json) {
    NSNumber* data = json;
    return data.doubleValue;
}

static CLLocationCoordinate2D* toLocation(id json) {
    NSArray* data = json;
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(toDouble(data[0]), toDouble(data[1]));
    CLLocationCoordinate2D* locA = &loc;
    return locA;
}
@end
