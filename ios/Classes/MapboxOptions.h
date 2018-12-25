//
//  MapboxOptions.h
//  Pods
//
//  Created by Barnabas Pataki on 2018. 12. 25..
//

#import <Flutter/Flutter.h>
#import <Mapbox/Mapbox.h>


@interface MapboxOptions : NSObject
- (instancetype)init;
- (void)parse:(id)json;
- (void)apply:(MGLMapView*)_view json:(id)json;
@end

