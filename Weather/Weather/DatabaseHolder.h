//
//  DatabaseHolder.h
//  Weather
//
//  Created by admin on 17/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "City.h"

@interface DatabaseHolder : NSObject
- (BOOL) addCity: (City *) city withError:(NSError **) error;
- (BOOL) setWeathers: (NSArray *) weathers forCity: (City *) city withError:(NSError **) error;
- (NSArray *) getCities;
- (NSArray *) getWeathersForCity: (City *) city;
- (BOOL) removeCity: (City *) city withError:(NSError **) error;
@end
