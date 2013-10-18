//
//  DetailViewController.m
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeathersCollectionViewController.h"
#import "Weather.h"

@interface DetailViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property WeathersCollectionViewController * detail;
@end

@implementation DetailViewController

- (void) setCity:(City *)city {
    _city = city;
    [[[CLGeocoder alloc] init] geocodeAddressString:city.name
                                  completionHandler:^(NSArray *placemarks, NSError *error) {
                                      if (error != nil) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error on City coordinates gathering"
                                                                      message:error.localizedDescription
                                                                     delegate:nil
                                                            cancelButtonTitle:nil
                                                            otherButtonTitles:@"OK", nil] show];
                                          return;
                                      }
                                      CLLocationCoordinate2D coor = [((CLPlacemark *)placemarks[0]) location].coordinate;
                                      [self.map setCenterCoordinate:coor
                                                           animated:YES];
                                      self.map.delegate = self;
                                      MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
                                      point.coordinate = coor;
                                      point.title = city.name;
                                      if ([city.weathers count] > 0) {
                                      Weather * w = city.weathers[0];
                                          point.subtitle = [NSString stringWithFormat:@"Min: %i°, Max: %i°", [w.tempMinC intValue] , [w.tempMaxC intValue]];
                                      }
                                      [self.map removeAnnotations:[self.map annotations]];
                                      [self.map addAnnotation:point];
                                          
                                  }];
    [self.detail setCity: city];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:MKPointAnnotation.class]) {
        MKAnnotationView * ann = [mapView dequeueReusableAnnotationViewWithIdentifier:@"beautifulMarker"];
        if (ann == nil){
            ann = [[MKAnnotationView alloc] init];
            ann.image = [UIImage imageNamed:@"Marker"];
            ann.centerOffset = CGPointMake(0, -16);
            [ann setEnabled: YES];
            [ann setCanShowCallout:YES];
        }
        return ann;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISplitViewController * split = self.splitViewController;
    split.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embededDetail"]){
        self.detail = segue.destinationViewController;
    }
}

//To be able to drag the cities list in portrait mode
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    barButtonItem.title = @"Cities";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    [self.navBar setItems:@[self.navigationItem] animated:YES];
    self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
