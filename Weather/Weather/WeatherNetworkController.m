//
//  WeatherNetworkController.m
//  Weather
//
//  Created by admin on 18/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "WeatherNetworkController.h"
#import <AFNetworking.h>
#import "Weather.h"

@implementation WeatherNetworkController

NSString * API_KEY = @"fhxpjbnwmgvaery2xgptay9k";
NSString * URL = @"http://api.worldweatheronline.com/free/v1/weather.ashx";

+ (void) requestWeathersForCityName:(NSString *) cityName
                         completion:(void (^)(NSArray * weathers, NSString * errorMsg)) callback {
    NSMutableArray * weathers = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL
      parameters:@{@"q": cityName,
                   @"format": @"json",
                   @"num_of_days": @(5),
                   @"key": API_KEY
                   }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             NSDictionary * data = ((NSDictionary *)responseObject);
             if (data[@"data"][@"error"]) {
                 NSLog(@"ERROR: %@", data[@"data"][@"error"][0][@"msg"]);
                 callback(nil, data[@"data"][@"error"][0][@"msg"]);
                 return;
             } else {
                 for (NSDictionary * w in data[@"data"][@"weather"]) {
                     [weathers addObject:[[Weather alloc] initWithDate:w[@"date"]
                                                              tempMaxC:[w[@"tempMaxC"] intValue]
                                                              tempMinC:[w[@"tempMinC"] intValue]
                                                              precipMM:[w[@"precipMM"] floatValue]
                                                         windSpeedKmph:[w[@"windspeedKmph"] intValue]
                                                         windDirDegree:[w[@"winddirDegree"] intValue]
                                                                  desc:w[@"weatherDesc"][0][@"value"]]];
                 }
                 callback(weathers, nil);
                 return;
             }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"ERROR: %@", [error localizedDescription]);
        callback(Nil, [error localizedDescription]);
    }];
}
@end
