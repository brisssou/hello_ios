//
//  City.h
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong) NSString * name;
@property NSMutableArray * weathers;

- (id) initWithName: (NSString *) name;

- (BOOL) isEqualToCity: (City *) other;
@end
