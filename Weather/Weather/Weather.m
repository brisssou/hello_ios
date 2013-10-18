//
//  Weather.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "Weather.h"
#import "NSObject+StringYYYYMMddToNSDate.h"
#import "NSDate+formatToFullString.h"

@implementation Weather
- (id) initWithDate: (NSString*) strDate
           tempMaxC: (int) max
           tempMinC: (int) min
           precipMM: (float) precip
      windSpeedKmph: (int) speed
      windDirDegree: (int) dir
               desc: (NSString *) d {
    if (self = [super init]){
        self.date = [strDate toDate];
        
        
        self.tempMaxC = @(max);
        self.tempMinC = @(min);
        self.precipMM = @(precip);
        self.windSpeedKmph = @(speed);
        self.windDirDegree = @(dir);
        self.desc = d;
    }
    return self;
}

- (id) initWithRealDate: (NSDate*) date
           tempMaxC: (int) max
           tempMinC: (int) min
           precipMM: (float) precip
      windSpeedKmph: (int) speed
      windDirDegree: (int) dir
               desc: (NSString *) d {
    if (self = [super init]){
        self.date = date;
        
        
        self.tempMaxC = @(max);
        self.tempMinC = @(min);
        self.precipMM = @(precip);
        self.windSpeedKmph = @(speed);
        self.windDirDegree = @(dir);
        self.desc = d;
    }
    return self;
}

- (NSString *) description {
    NSMutableString * str = [[NSMutableString alloc] init];
    [str appendFormat:@"date: %@\n", [self.date formatToFullString]];
    [str appendFormat:@"temp. max: %i°C\n", [self.tempMaxC intValue]];
    [str appendFormat:@"temp. min: %i°C\n", [self.tempMinC intValue]];
    [str appendFormat:@"precip. : %1.2fmm\n", [self.precipMM floatValue]];
    [str appendFormat:@"wind speed: %i km/h\n", [self.windSpeedKmph intValue]];
    [str appendFormat:@"wind dir: %i°\n", [self.windDirDegree intValue]];
    [str appendFormat:@"desc: %@\n", self.desc];
    
    return [str description];
}

@end
