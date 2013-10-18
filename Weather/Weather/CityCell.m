//
//  CityCell.m
//  Weather
//
//  Created by admin on 18/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "CityCell.h"
#import "WeatherDataController.h"

@implementation CityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)updateButtonClicked:(id)sender {
    NSLog(@"updating %@", self.cityName.text);
    WeatherDataController * data = [WeatherDataController getInstance];
    [data updateWeatherForCityName:self.cityName.text];
}
@end
