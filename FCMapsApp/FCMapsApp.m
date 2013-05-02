//
//  FCMapsApp.m
//
//  Created by Fabio Caccamo on 17/02/13.
//  Copyright (c) 2013 Fabio Caccamo. All rights reserved.
//

#import "FCMapsApp.h"
#import "FCCurrentLocationGeocoder.h"


#define kGOOGLE_MAPS_URL_SCHEME @"comgooglemaps://"
#define kAPPLE_MAPS_URL_SCHEME_IOS5 @"http://maps.google.com/maps"
#define kAPPLE_MAPS_URL_SCHEME_IOS6 @"http://maps.apple.com/"


@implementation FCMapsApp


+(NSString *)formatDirectionsMode:(MapsDirectionsMode)directionsmode
{
    NSString * directionsmodeValue = @"";
    
    switch (directionsmode)
    {
        case MapsDirectionsModeDriving:
            directionsmodeValue = @"driving";
            break;
            
        case MapsDirectionsModeTransit:
            directionsmodeValue = @"transit";
            break;
            
        case MapsDirectionsModeWalking:
            directionsmodeValue = @"walking";
            break;
    }
    
    return [NSString stringWithFormat:@"directionsmode=%@", directionsmodeValue];
}


+(NSString *)formatLocation:(CLLocationCoordinate2D)location as:(NSString *)as
{
    return [NSString stringWithFormat:@"%@=%f,%f", as, location.latitude, location.longitude];
}


+(NSString *)formatMapmode:(int)mapmode
{
    NSString * mapmodeValue = @"";
    
    switch (mapmode)
    {
        case MapsModeStandard:
            mapmodeValue = @"standard";
            break;
            
        case MapsModeStreetView:
            mapmodeValue = @"streetview";
            break;
    }
    
    return [NSString stringWithFormat:@"mapmode=%@", mapmodeValue];
}


+(NSString *)formatSearch:(NSString *)search
{
    return [NSString stringWithFormat:@"q=%@", [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}


+(NSString *)formatViews:(int)views
{
    NSString * viewsString = @"";
    NSMutableArray * viewsValues = [NSMutableArray array];
    
    if((views & MapsViewSatellite) == MapsViewSatellite)
    {
        [viewsValues addObject:@"satellite"];
    }
    
    if((views & MapsViewTraffic) == MapsViewTraffic)
    {
        [viewsValues addObject:@"traffic"];
    }
    
    if((views & MapsViewTransit) == MapsViewTransit)
    {
        [viewsValues addObject:@"transit"];
    }
    
    if([viewsValues count] > 0)
    {
        viewsString = [viewsValues componentsJoinedByString:@","];
    }
    
    return [NSString stringWithFormat:@"views=%@", viewsString];
}


static BOOL _useGoogleMaps = TRUE;


+(void)useGoogleMaps:(BOOL)value
{
    _useGoogleMaps = value;
}


+(BOOL)isGoogleMapsInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kGOOGLE_MAPS_URL_SCHEME]];
}


+(void)launchWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation withTransportationMode:(MapsDirectionsMode)transportationMode
{
    FCCurrentLocationGeocoder * currentLocationGeocoder = [[FCCurrentLocationGeocoder alloc] init];
    
    [currentLocationGeocoder startGeocode:^(BOOL success)
     {
         if(success)
         {
             CLLocationCoordinate2D currentLocation = currentLocationGeocoder.location.coordinate;
             
             [FCMapsApp launchWithDirectionsFromLocation:currentLocation toLocation:toLocation withTransportationMode:transportationMode];
         }
         else {
             
             NSArray * parameters = [NSArray arrayWithObjects:
                                     @"saddr=",
                                     [FCMapsApp formatLocation:toLocation as:@"daddr"],
                                     [FCMapsApp formatDirectionsMode:transportationMode],
                                     [FCMapsApp formatMapmode:MapsModeStandard],
                                     nil];
             
             [FCMapsApp launchWithParameters:parameters];
         }
     }];
}


+(void)launchWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation withTransportationMode:(MapsDirectionsMode)transportationMode
{
    if(CLLocationCoordinate2DIsValid(fromLocation) && CLLocationCoordinate2DIsValid(toLocation))
    {
        NSArray * parameters = [NSArray arrayWithObjects:
                                [FCMapsApp formatLocation:fromLocation as:@"saddr"],
                                [FCMapsApp formatLocation:toLocation as:@"daddr"],
                                [FCMapsApp formatDirectionsMode:transportationMode],
                                [FCMapsApp formatMapmode:MapsModeStandard],
                                nil];
        
        [FCMapsApp launchWithParameters:parameters];
    }
}


+(void)launchWithLocation:(CLLocationCoordinate2D)location useViews:(int)views
{
    if(CLLocationCoordinate2DIsValid(location))
    {
        NSArray * parameters = [NSArray arrayWithObjects:
                                [FCMapsApp formatLocation:location as:@"q"],
                                [FCMapsApp formatViews:views],
                                [FCMapsApp formatMapmode:MapsModeStandard],
                                nil];
        
        [FCMapsApp launchWithParameters:parameters];
    }
}


+(void)launchWithSearch:(NSString *)search useViews:(int)views
{
    if(![search isEqualToString:@""])
    {
        NSArray * parameters = [NSArray arrayWithObjects:
                                [FCMapsApp formatSearch:search],
                                [FCMapsApp formatViews:views],
                                [FCMapsApp formatMapmode:MapsModeStandard],
                                nil];
        
        [FCMapsApp launchWithParameters:parameters];
    }
}


+(void)launchWithSearch:(NSString *)search nearLocation:(CLLocationCoordinate2D)location useViews:(int)views
{
    if(![search isEqualToString:@""] && CLLocationCoordinate2DIsValid(location))
    {
        NSArray * parameters = [NSArray arrayWithObjects:
                                [FCMapsApp formatSearch:search],
                                [FCMapsApp formatLocation:location as:@"center"],
                                [FCMapsApp formatLocation:location as:@"near"], //added for apple maps, google maps ignore it
                                [FCMapsApp formatViews:views],
                                [FCMapsApp formatMapmode:MapsModeStandard],
                                nil];
        
        [FCMapsApp launchWithParameters:parameters];
    }
}


+(void)launchWithSearchNearCurrentLocation:(NSString *)search useViews:(int)views
{
    FCCurrentLocationGeocoder * currentLocationGeocoder = [[FCCurrentLocationGeocoder alloc] init];
    
    [currentLocationGeocoder startGeocode:^(BOOL success)
     {
         if(success)
         {
             CLLocationCoordinate2D currentLocation = currentLocationGeocoder.location.coordinate;
             
             [FCMapsApp launchWithSearch:search nearLocation:currentLocation useViews:views];
         }
     }];
}


+(void)launchWithParameters:(NSArray *)parameters
{
    NSString * urlQueryString = [NSString stringWithFormat:@"?%@", [parameters componentsJoinedByString:@"&"]];
    NSString * urlPrefix;
    NSString * urlString;
    NSURL * url;
    
    if(_useGoogleMaps && [FCMapsApp isGoogleMapsInstalled])
    {
        urlPrefix = kGOOGLE_MAPS_URL_SCHEME;
    }
    else {
        
        float iOS6 = 6.0;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue] < iOS6)
        {
            urlPrefix = kAPPLE_MAPS_URL_SCHEME_IOS5;
        }
        else {
            urlPrefix = kAPPLE_MAPS_URL_SCHEME_IOS6;
        }
    }
    
    urlString = [NSString stringWithFormat:@"%@%@", urlPrefix, urlQueryString];
    //NSLog(@"%@", urlString);
    
    url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
}


@end