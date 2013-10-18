//
//  AddCityPopOverViewController.m
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "AddCityPopOverViewController.h"
#import "WeatherDataController.h"

@interface AddCityPopOverViewController ()

@property (weak, nonatomic) IBOutlet UITextField *cityNameField;

@end

@implementation AddCityPopOverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneClicked:(id)sender {
    NSString * cityName = [self.cityNameField text];
    WeatherDataController * data = [WeatherDataController getInstance];
    NSError * error;
    if (![data addCityWithName:cityName
                   andWeathers:@[]
                      andError: &error]) {
        [self.errorLabel setAlpha:0];
        [self.errorLabel setText:[error localizedDescription]];
        [UIView animateWithDuration:0.7
                              delay:0
                            options:0
                         animations:^{
                             [self.errorLabel setAlpha:1];
                         }
                         completion:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cityAdded"
                                                            object:nil];
        [self.cityNameField setText: @""];
        [self.delegate cityAdded:self];
    }
}
@end
