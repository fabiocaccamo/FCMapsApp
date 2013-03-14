#FCMapsApp

Utility class that provides many methods for launch the Maps App.
The class try to launch the GoogleMaps app, in case GoogleMaps is not installed AppleMaps will be launched.

##Requirements & Dependecies

- iOS >= 5.0
- CoreLocation Framework
- [FCCurrentLocationGeocoder](https://github.com/fabiocaccamo/FCCurrentLocationGeocoder)

##API

```objective-c
+(BOOL)isGoogleMapsInstalled;
```
```objective-c
+(BOOL)launchWithCenter:(CLLocationCoordinate2D)center 
		andZoom:(int)zoom 
		useViews:(int)views;
```
```objective-c
+(BOOL)launchWithDirectionsFromCurrentLocationToLocation:(CLLocationCoordinate2D)toLocation 
		withTransportationMode:(GoogleMapsDirectionsMode)transportationMode;
```
```objective-c
+(BOOL)launchWithDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation 
		toLocation:(CLLocationCoordinate2D)toLocation 
		withTransportationMode:(GoogleMapsDirectionsMode)transportationMode;
```
```objective-c
+(BOOL)launchWithLocation:(CLLocationCoordinate2D)location 
		useViews:(int)views;
```
```objective-c
+(BOOL)launchWithSearch:(NSString *)search 
		useViews:(int)views;
```
```objective-c
+(BOOL)launchWithSearch:(NSString *)search 
		nearLocation:(CLLocationCoordinate2D)location 
		useViews:(int)views;
```

##License

Copyright (c) 2013 Fabio Caccamo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
