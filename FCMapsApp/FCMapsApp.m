//
//  FCMapsApp.m
//
//  Created by Fabio Caccamo on 17/02/13.
//  Copyright (c) 2013 Fabio Caccamo. All rights reserved.
//

#import "FCCurrentLocationGeocoder.h"
#import "FCMapsApp.h"


#define kAPPLE_MAPS_URL_SCHEME_IOS5 @"http://maps.google.com/maps"
#define kAPPLE_MAPS_URL_SCHEME @"http://maps.apple.com/"
#define kGOOGLE_MAPS_URL_SCHEME @"comgooglemaps://"
#define kGOOGLE_MAPS_URL_SCHEME_X_CALLBACK_URL @"comgooglemaps-x-callback://"
#define kWAZE_URL_SCHEME @"waze://"
#define kYANDEX_MAPS_URL_SCHEME @"yandexmaps://maps.yandex.ru/"


@implementation FCMapsApp


static const CLLocationCoordinate2D currentLocationCoordinate = {-1000, -1000};
static const CLLocationCoordinate2D geocodeLocationCoordinate = {-1001, -1001};


+(BOOL)canLaunchAppleMaps
{
    return [self canOpenURLWithString:kAPPLE_MAPS_URL_SCHEME];
}


+(BOOL)canLaunchGoogleMaps
{
    return [self canOpenURLWithString:kGOOGLE_MAPS_URL_SCHEME];
}


+(BOOL)canLaunchGoogleMapsWithXCallbackURL
{
    return [self canOpenURLWithString:kGOOGLE_MAPS_URL_SCHEME_X_CALLBACK_URL];
}


+(BOOL)canLaunchWaze
{
    return [self canOpenURLWithString:kWAZE_URL_SCHEME];
}


+(BOOL)canLaunchYandexMaps
{
    return [self canOpenURLWithString:kYANDEX_MAPS_URL_SCHEME];
}


+(BOOL)canOpenURLWithString:(NSString *)url
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}


+(void)launchAppleMapsWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode
{
    [FCMapsApp launchAppleMapsWithDirectionsFromLocation:geocodeLocationCoordinate toLocation:toLocation transportationMode:transportationMode];
}


+(void)launchAppleMapsWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode
{
    //BOOL iOS5 = ![self canLaunchAppleMaps];
    BOOL iOS5 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0);
    
    if((fromLocation.latitude == geocodeLocationCoordinate.latitude) && (fromLocation.longitude == geocodeLocationCoordinate.longitude))
    {
        FCCurrentLocationGeocoder * currentLocationGeocoder = [[FCCurrentLocationGeocoder alloc] init];
        currentLocationGeocoder.prompt = iOS5;
        [currentLocationGeocoder geocode:^(BOOL success){
            
            if(success)
            {
                CLLocationCoordinate2D currentLocation = currentLocationGeocoder.location.coordinate;
                
                [FCMapsApp launchAppleMapsWithDirectionsFromLocation:currentLocation toLocation:toLocation transportationMode:transportationMode];
            }
            else {
                
                if(!iOS5)
                {
                    [FCMapsApp launchAppleMapsWithDirectionsFromLocation:currentLocationCoordinate toLocation:toLocation transportationMode:transportationMode];
                }
            }
        }];
        
        return;
    }
    
    
    NSString *queryString;
    
    if(iOS5)
    {
        /*
         http://stackoverflow.com/questions/1056984/open-google-maps-to-bus-directions
         
         dirflg=h - Switches on "Avoid Highways" route finding mode.
         dirflg=t - Switches on "Avoid Tolls" route finding mode.
         dirflg=r - Switches on "Public Transit" - only works in some areas.
         dirflg=w - Switches to walking directions - still in beta.
         dirflg=d - Switches to driving directions.
         
         maps transit mode not supported
         https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
        */
        
        queryString = [NSString stringWithFormat:@"saddr=%@&daddr=%@&dirflg=%@",
                            [NSString stringWithFormat:@"%f,%f", fromLocation.latitude, fromLocation.longitude],
                            [NSString stringWithFormat:@"%f,%f", toLocation.latitude, toLocation.longitude],
                            [@[@"d", @"w"] objectAtIndex:transportationMode]
                        ];
    }
    else {
        
        queryString = [NSString stringWithFormat:@"saddr=%@&daddr=%@&directionsmode=%@",
                            (((fromLocation.latitude == currentLocationCoordinate.latitude) && (fromLocation.longitude == currentLocationCoordinate.longitude)) ? @"Current+Location" : [NSString stringWithFormat:@"%f,%f", fromLocation.latitude, fromLocation.longitude]),
                            [NSString stringWithFormat:@"%f,%f", toLocation.latitude, toLocation.longitude],
                            [@[@"driving", @"walking"] objectAtIndex:transportationMode]
                        ];
    }
    
    [self launchAppleMapsWithQueryString:queryString];
}


+(void)launchAppleMapsWithLocation:(CLLocationCoordinate2D)location
{
    if(CLLocationCoordinate2DIsValid(location))
    {
        NSString *queryString = [NSString stringWithFormat:@"q=%f,%f", location.latitude, location.longitude];
        
        [self launchAppleMapsWithQueryString:queryString];
    }
}


+(void)launchAppleMapsWithQueryString:(NSString *)queryString
{
    [self openURLWithScheme:kAPPLE_MAPS_URL_SCHEME andQueryString:queryString];
}


+(void)launchGoogleMapsWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode
{
    [FCMapsApp launchGoogleMapsWithDirectionsFromLocation:geocodeLocationCoordinate toLocation:toLocation transportationMode:transportationMode];
}


+(void)launchGoogleMapsWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation transportationMode:(MapsDirectionsMode)transportationMode
{
    if([self canLaunchGoogleMaps])
    {
        if((fromLocation.latitude == geocodeLocationCoordinate.latitude) && (fromLocation.longitude == geocodeLocationCoordinate.longitude))
        {
            FCCurrentLocationGeocoder * currentLocationGeocoder = [[FCCurrentLocationGeocoder alloc] init];
            currentLocationGeocoder.prompt = NO;
            [currentLocationGeocoder geocode:^(BOOL success){
                
                if(success)
                {
                    CLLocationCoordinate2D currentLocation = currentLocationGeocoder.location.coordinate;
                    
                    [FCMapsApp launchGoogleMapsWithDirectionsFromLocation:currentLocation toLocation:toLocation transportationMode:transportationMode];
                }
                else {
                    
                    [FCMapsApp launchGoogleMapsWithDirectionsFromLocation:currentLocationCoordinate toLocation:toLocation transportationMode:transportationMode];
                }
            }];
            
            return;
        }
        
        NSString *queryString = [NSString stringWithFormat:@"saddr=%@&daddr=%@&directionsmode=%@",
                                    (((fromLocation.latitude == currentLocationCoordinate.latitude) && (fromLocation.longitude == currentLocationCoordinate.longitude)) ? @"" : [NSString stringWithFormat:@"%f,%f", fromLocation.latitude, fromLocation.longitude]),
                                    [NSString stringWithFormat:@"%f,%f", toLocation.latitude, toLocation.longitude],
                                    [@[@"driving", @"walking"] objectAtIndex:transportationMode]
                                ];
        
        [self launchGoogleMapsWithQueryString:queryString];
    }
}


+(void)launchGoogleMapsWithLocation:(CLLocationCoordinate2D)location
{
    if(CLLocationCoordinate2DIsValid(location))
    {
        NSString *queryString = [NSString stringWithFormat:@"q=%f,%f", location.latitude, location.longitude];
        
        [self launchGoogleMapsWithQueryString:queryString];
    }
}


+(void)launchGoogleMapsWithQueryString:(NSString *)queryString
{
    /*
    //TODO: add support for x-callback-url
    
    if([self canLaunchGoogleMapsWithXCallbackURL])
    {
        NSString *appName = [[NSBundle bundleWithIdentifier:@"BundleIdentifier"] objectForInfoDictionaryKey:@"CFBundleExecutable"];
        NSString *appScheme = @"";
     
        //http://stackoverflow.com/questions/7244317/will-my-app-respond-to-a-url-scheme
        
        //get the first urltype
        BOOL schemeIsInPlist = NO; // find out if the sceme is in the plist file.
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSArray* cfBundleURLTypes = [mainBundle objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([cfBundleURLTypes isKindOfClass:[NSArray class]] && [cfBundleURLTypes lastObject]) {
            NSDictionary* cfBundleURLTypes0 = [cfBundleURLTypes objectAtIndex:0];
            if ([cfBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                NSArray* cfBundleURLSchemes = [cfBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([cfBundleURLSchemes isKindOfClass:[NSArray class]]) {
                    for (NSString* scheme in cfBundleURLSchemes) {
                        if ([scheme isKindOfClass:[NSString class]] && [url hasPrefix:scheme]) {
                            schemeIsInPlist = YES;
                            break;
                        }
                    }
                }
            }
        }
        
        //then add parameters to the query-string
        queryString = [NSString stringWithFormat:@"%@&x-success=%@&x-source=%@", queryString, appName, appScheme];
        
        
        [self openURLWithScheme:kGOOGLE_MAPS_URL_SCHEME_X_CALLBACK_URL andQueryString:queryString];
    }
    else {
        [self openURLWithScheme:kGOOGLE_MAPS_URL_SCHEME andQueryString:queryString];
    }
    */
    
    [self openURLWithScheme:kGOOGLE_MAPS_URL_SCHEME andQueryString:queryString];
}


+(void)launchWazeWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation 
{
    NSString * queryString = [NSString stringWithFormat:@"ll=%f,%f&navigate=yes", toLocation.latitude, toLocation.longitude];
    
    [self openURLWithScheme:kWAZE_URL_SCHEME andQueryString:queryString];
}


+(void)launchYandexMapsWithLocation:(CLLocationCoordinate2D)location
{
    NSString *queryString = [NSString stringWithFormat:@"pt=%f,%f", location.longitude, location.latitude];
    
    [self openURLWithScheme:kYANDEX_MAPS_URL_SCHEME andQueryString:queryString];
}


+(void)openURLWithScheme:(NSString *)urlScheme andQueryString:(NSString *)queryString
{
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", urlScheme, queryString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if( [[UIApplication sharedApplication] canOpenURL:url] ){
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end

