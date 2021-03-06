//
//  BaseMapViewController.m
//  StrangerDanger
//
//  Created by Matthew Faluotico on 4/11/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "BaseMapViewController.h"

@interface BaseMapViewController ()

@end

@implementation BaseMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    
    [self.manager startUpdatingLocation];
    
    [self askUserForLocation];
    [self zoomToCurrentLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) askUserForLocation {
    if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
        [self.manager  requestWhenInUseAuthorization];
    }
}

- (void) zoomToCurrentLocation {
    MKCoordinateRegion zoomin = MKCoordinateRegionMakeWithDistance(self.manager.location.coordinate, 1500, 1500);
    [self.mapView setRegion:zoomin animated:YES];
}

- (void) placePoint: (MKPlacemark *) mark  {
    [self.mapView addAnnotation:mark];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self zoomToCurrentLocation];
    NSLog(@"fire");
    self.userLocation = self.mapView.userLocation.location;
    
    NSLog(@"%f", self.userLocation.coordinate.longitude);
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self zoomToCurrentLocation];
    self.userLocation = self.mapView.userLocation.location;
}


@end
