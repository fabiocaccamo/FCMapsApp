#FCMapsApp

Launch Maps application to show a location, do a search or get directions. <br />
It is possible to choose if use Google Maps (if installed used by default) or Apple Maps. <br />

##Requirements & Dependecies

- iOS >= 5.0
- CoreLocation Framework
- [FCCurrentLocationGeocoder](https://github.com/fabiocaccamo/FCCurrentLocationGeocoder)

##API

```objective-c
//check if Google Maps app is installed on the device
+(BOOL)isGoogleMapsInstalled;
```
```objective-c
//if YES (and if Google Maps app is installed) use Google Maps app, if NO use Apple Maps app. default YES
+(void)useGoogleMaps;
```
```objective-c
+(void)launchWithCenter:(CLLocationCoordinate2D)center 
		andZoom:(int)zoom 
		useViews:(int)views;
```
```objective-c
+(void)launchWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation 
		withTransportationMode:(GoogleMapsDirectionsMode)transportationMode;
```
```objective-c
+(void)launchWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation 
		toLocation:(CLLocationCoordinate2D)toLocation 
		withTransportationMode:(GoogleMapsDirectionsMode)transportationMode;
```
```objective-c
+(void)launchWithLocation:(CLLocationCoordinate2D)location 
		useViews:(int)views;
```
```objective-c
+(void)launchWithSearch:(NSString *)search 
		useViews:(int)views;
```
```objective-c
+(void)launchWithSearch:(NSString *)search 
		nearLocation:(CLLocationCoordinate2D)location 
		useViews:(int)views;
```
```objective-c
+(void)launchWithSearchNearCurrentLocation:(NSString *)search 
		useViews:(int)views;
```

##License

Copyright (c) 2013 Fabio Caccamo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
