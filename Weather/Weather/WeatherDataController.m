//
//  WeatherDataController.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "WeatherDataController.h"
#import "City.h"

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
    }
    return self;
}

- (BOOL) addCityWithName:(NSString *) cityName
              addError: (NSError **) error {
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
    [self.cities addObject : c];
    
    [self.cities sortUsingComparator:^NSComparisonResult(id o1, id o2){
        return [[o1 name] compare:[o2 name]];
    }];
    return YES;
}

- (id) removeCityAtIndex: (int) index {
    if (index < [self.cities count])
        [self.cities removeObjectAtIndex: index];
    return self;
}

- (id) removeCityWithName: (NSString *) cityName {
    int indx = -1;
    City * c;
    for (int i = 0; i<self.cities.count; i++) {
        c = [self.cities objectAtIndex: i];
        if ([[c name] isEqualToString: cityName]) {
            indx = i;
        }
    }
    if (indx != -1){
        [self.cities removeObjectAtIndex: indx];
    }
    return self;
}
@end
