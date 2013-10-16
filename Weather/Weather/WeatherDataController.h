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
@property NSMutableArray * cities;
- (BOOL) addCityWithName:(NSString *) cityName
              addError: (NSError **) error;
- (id) removeCityAtIndex: (int) index;
- (id) removeCityWithName: (NSString *) cityName;
@end
