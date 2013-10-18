//
//  WeatherDataController.h
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDataController : NSObject
+ (id) getInstance;
@property (nonatomic) NSMutableArray * cities;
- (BOOL) addCityWithName:(NSString *) cityName
             andWeathers:(NSArray *) weathers
              andError: (NSError **) error;
- (id) removeCityAtIndex: (int) index;
- (id) removeCityWithName: (NSString *) cityName;
- (void) updateWeatherForCityName: (NSString *) cityName;
@end
