//
//  FCMapsApp.h
//
//  Created by Fabio Caccamo on 17/02/13.
//  Copyright (c) 2013 Fabio Caccamo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef enum {
    MapsModeStandard,
    MapsModeStreetView
} MapsMode;


typedef enum {
    MapsViewDefault, 
    MapsViewSatellite,
    MapsViewTraffic,
	MapsViewTransit
} MapsView;


typedef enum {
    MapsDirectionsModeDriving,
	MapsDirectionsModeTransit,
    MapsDirectionsModeWalking
} MapsDirectionsMode;


@interface FCMapsApp:NSObject


+(void)useGoogleMaps:(BOOL)value;
+(BOOL)isGoogleMapsInstalled;

+(void)launchWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation withTransportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation withTransportationMode:(MapsDirectionsMode)transportationMode;

+(void)launchWithLocation:(CLLocationCoordinate2D)location useViews:(int)views;

+(void)launchWithSearch:(NSString *)search useViews:(int)views;
+(void)launchWithSearch:(NSString *)search nearLocation:(CLLocationCoordinate2D)location useViews:(int)views;
+(void)launchWithSearchNearCurrentLocation:(NSString *)search useViews:(int)views;

@end