//
//  WeatherCell.m
//  Weather
//
//  Created by admin on 17/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "WeatherCell.h"
#import "NSDate+formatToFullString.h"

@implementation WeatherCell

- (void)setWeather:(Weather *)weather {
    self.descLabel.text = weather.desc;
    self.dateLabel.text = [weather.date formatToFullString];
    self.tempMaxLabel.text = [NSString stringWithFormat:@"%i °", [weather.tempMaxC intValue]];
    self.tempMinLabel.text = [NSString stringWithFormat:@"%i °", [weather.tempMinC intValue]];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%i km/h", [weather.windSpeedKmph intValue]];
    self.windDirImg.transform = CGAffineTransformMakeRotation(M_1_PI*[weather.windDirDegree floatValue]/180);
    self.precipitationLabel.text = [NSString stringWithFormat:@"%f mm", [weather.precipMM floatValue]];
}

@end
