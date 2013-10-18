//
//  WeatherNetworkController.h
//  Weather
//
//  Created by admin on 18/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherNetworkController : NSObject
+ (void) requestWeathersForCityName:(NSString *) cityName
                         completion:(void (^)(NSArray * weathers, NSString * errorMsg)) callback;
@end
