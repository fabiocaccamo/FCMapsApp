//
//  FCMapsApp.h
//
//  Created by Fabio Caccamo on 17/02/13.
//  Copyright (c) 2013 Fabio Caccamo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>

/*
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
*/

typedef enum {
    MapsDirectionsModeDriving,
    MapsDirectionsModeWalking
} MapsDirectionsMode;


@interface FCMapsApp:NSObject

+(BOOL)canLaunchAppleMaps;
+(BOOL)canLaunchGoogleMaps;
+(BOOL)canLaunchWaze;
+(BOOL)canLaunchYandexMaps;

+(void)launchAppleMapsWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchAppleMapsWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchAppleMapsWithLocation:(CLLocationCoordinate2D)location;
//+(void)launchAppleMapsWithSearch:(NSString *)search;
//+(void)launchAppleMapsWithSearch:(NSString *)search nearLocation:(CLLocationCoordinate2D)location;
//+(void)launchAppleMapsWithSearchNearCurrentLocation:(NSString *)search;

+(void)launchGoogleMapsWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchGoogleMapsWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchGoogleMapsWithLocation:(CLLocationCoordinate2D)location;
//+(void)launchGoogleMapsWithSearch:(NSString *)search;
//+(void)launchGoogleMapsWithSearch:(NSString *)search nearLocation:(CLLocationCoordinate2D)location;
//+(void)launchGoogleMapsWithSearchNearCurrentLocation:(NSString *)search;

+(void)launchWazeWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation;

//+(void)launchYandexMapsWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
//+(void)launchYandexMapsWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode;
+(void)launchYandexMapsWithLocation:(CLLocationCoordinate2D)location;
//+(void)launchYandexMapsWithSearch:(NSString *)search useViews:(int)views;
//+(void)launchYandexMapsWithSearch:(NSString *)search nearLocation:(CLLocationCoordinate2D)location useViews:(int)views;
//+(void)launchYandexMapsWithSearchNearCurrentLocation:(NSString *)search useViews:(int)views;

@end

