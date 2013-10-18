//
//  DetailViewController.m
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "DetailViewController.h"
#import "WeathersCollectionViewController.h"

@interface DetailViewController ()
@property WeathersCollectionViewController * detail;
@end

@implementation DetailViewController

- (void) setCity:(City *)city {
    _city = city;
    [self.detail setCity: city];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
@end
