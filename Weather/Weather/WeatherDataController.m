//
//  WeatherDataController.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "WeatherDataController.h"
#import "City.h"
#import "DatabaseHolder.h"
#import "Weather.h"
#import "WeatherNetworkController.h"

@interface WeatherDataController ()
@property DatabaseHolder * database;
@end



@implementation WeatherDataController

static WeatherDataController *sharedInstance;

+ (id) getInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id) init {
    if (self = [super init]) {
        self.cities = [[NSMutableArray alloc] init];
        self.database = [[DatabaseHolder alloc] init];
    }
    return self;
}

- (BOOL) addCityWithName:(NSString *) cityName
             andWeathers:(NSMutableArray *)weathers
                andError: (NSError **) error {
    if ([cityName length] == 0){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"City name is empty" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"world" code:200 userInfo:details];
        return NO;
    }
    
    City * c;
    for (int i = 0; i<self.cities.count; i++) {
        c = [self.cities objectAtIndex: i];
        if ([[c name] isEqualToString: cityName]) {
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"City already existing in the list" forKey:NSLocalizedDescriptionKey];
            *error = [NSError errorWithDomain:@"world" code:200 userInfo:details];
            return NO;
        }
    }

    c = [[City alloc] initWithName: cityName];
    
    c.weathers = weathers;
    
    c.weathers = [@[[[Weather alloc] initWithDate:@"2013-10-12"
                                                            tempMaxC:12
                                                            tempMinC:5
                                                            precipMM:32.
                                                       windSpeedKmph:666
                                                       windDirDegree:42
                                                                desc:@"c'est vraiment très intéressant"]
                                                       ] mutableCopy]
        ;
    
    [self.cities addObject : c];
    
    [self.cities sortUsingComparator:^NSComparisonResult(id o1, id o2){
        return [[o1 name] compare:[o2 name]];
    }];
    [self.database addCity:c withError:error];
    [self updateWeatherForCityName:c.name];
    return YES;
}

- (void)updateWeatherForCityName:(NSString *)cityName {
    [WeatherNetworkController requestWeathersForCityName:cityName
                                              completion:^(NSArray *weathers, NSString *errorMsg) {
                                                  
                                                  if (errorMsg == nil){
                                                      NSError * error;
                                                      [self.database setWeathers:weathers
                                                                         forCityName:cityName withError:&error];
                                                  }else
                                                      [[[UIAlertView alloc] initWithTitle:@"Error on Weather data gathering"
                                                                                  message:errorMsg
                                                                                 delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                                              }];

}

- (NSMutableArray *)cities{
    _cities = [[self.database getCities] mutableCopy];
    for (City * c in _cities) {
        c.weathers = [[self.database getWeathersForCity:c] mutableCopy];
    }
    return _cities;
}

- (id) removeCityAtIndex: (int) index {
    if (index < [self.cities count]){
        NSError * error;
        City * c = self.cities[index];
        [self.database removeCity:c withError:&error];
    }
    return self;
}

- (id) removeCityWithName: (NSString *) cityName {
    int indx = -1;
    City * c;
    for (int i = 0; i<self.cities.count; i++) {
        c = [self.cities objectAtIndex: i];
        if ([[c name] isEqualToString: cityName]) {
            indx = i;
            break;
        }
    }
    if (indx != -1){
        [self.cities removeObjectAtIndex: indx];
        NSError * error;
        [self.database removeCity:c withError:&error];
    }
    return self;
}
@end
