//
//  AppViewController.m
//  FCMapsAppDemo
//
//  Created by Fabio Caccamo on 14/03/13.
//  Copyright (c) 2013 Fabio Caccamo. All rights reserved.
//

#import "AppViewController.h"
#import "FCMapsApp.h"

@interface AppViewController ()

@end

@implementation AppViewController


-(void)btnTouched:(UIButton *)sender
{
    CLLocationCoordinate2D knz = CLLocationCoordinate2DMake(45.07662582, 7.67537260);
    CLLocationCoordinate2D ats = CLLocationCoordinate2DMake(-21.96656150, -47.93837670);
    
    CLLocationCoordinate2D torino = CLLocationCoordinate2DMake(45.062902, 7.67849);
    CLLocationCoordinate2D milano = CLLocationCoordinate2DMake(45.465454, 9.186516);
    
    
    if(sender == _btn1)
    {
        [FCMapsApp launchWithDirectionsFromCurrentLocationToLocation:knz withTransportationMode:MapsDirectionsModeDriving];
    }
    else if(sender == _btn2)
    {
        [FCMapsApp launchWithDirectionsFromLocation:torino toLocation:milano withTransportationMode:MapsDirectionsModeDriving ];
    }
    else if(sender == _btn3)
    {
        [FCMapsApp launchWithLocation:knz useViews:MapsViewSatellite | MapsViewTraffic];
    }
    else if(sender == _btn4)
    {
        [FCMapsApp launchWithSearch:@"Torino, Italy" useViews:MapsViewTransit];
    }
    else if(sender == _btn5)
    {
        [FCMapsApp launchWithSearch:@"Pizza" nearLocation:ats useViews:MapsViewDefault];
    }
    else if(sender == _btn6)
    {
        [FCMapsApp launchWithSearchNearCurrentLocation:@"Pizza" useViews:MapsViewDefault];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    float btnTop = 30.0;
    float btnFontSize = 13.0;
    float btnX = 15;
    float btn2X = btnX * 2.0;
    float btnWidth = self.view.frame.size.width - btn2X;
    float btnHeight = 50.0;
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn1.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn1 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn2.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn2 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn3.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn3 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn4.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn4.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn4 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn5.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn5.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn5 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn6.titleLabel setFont:[UIFont systemFontOfSize:btnFontSize]];
    _btn6.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_btn6 addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tit = [[UILabel alloc] initWithFrame:CGRectMake(btnX, 15.0, btnWidth, 20.0)];
    [_tit setText:@"FCMapsApp launchWith..."];
    [self.view addSubview:_tit];
    
    
    [_btn1 setTitle:@"DirectionsFromCurrentLocationToLocation" forState:UIControlStateNormal];
    _btn1.frame = CGRectMake(btnX, btnTop + 20, btnWidth, btnHeight);
    [self.view addSubview:_btn1];
    
    _btn2.frame = CGRectMake(btnX, btnTop + 75, btnWidth, btnHeight);
    [_btn2 setTitle:@"DirectionsFromLocationToLocation" forState:UIControlStateNormal];
    [self.view addSubview:_btn2];
    
    [_btn3 setTitle:@"Location" forState:UIControlStateNormal];
    _btn3.frame = CGRectMake(btnX, btnTop + 130, btnWidth, btnHeight);
    [self.view addSubview:_btn3];
    
    [_btn4 setTitle:@"Search" forState:UIControlStateNormal];
    _btn4.frame = CGRectMake(btnX, btnTop + 185, btnWidth, btnHeight);
    [self.view addSubview:_btn4];
    
    [_btn5 setTitle:@"SearchNearLocation" forState:UIControlStateNormal];
    _btn5.frame = CGRectMake(btnX, btnTop + 240, btnWidth, btnHeight);
    [self.view addSubview:_btn5];
    
    [_btn6 setTitle:@"SearchNearCurrentLocation" forState:UIControlStateNormal];
    _btn6.frame = CGRectMake(btnX, btnTop + 295, btnWidth, btnHeight);
    [self.view addSubview:_btn6];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([FCMapsApp isGoogleMapsInstalled])
    {
        [[[UIAlertView alloc] initWithTitle:@"GoogleMaps is installed" message:@"GoogleMaps App will be used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"GoogleMaps is not installed" message:@"Apple Maps App will be used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
