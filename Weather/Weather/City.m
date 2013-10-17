//
//  City.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "City.h"
#import "Weather.h"

@implementation City
- (id)initWithName:(NSString *)name{
    if (self = [ super init]){
        self.name = name;
        self.weathers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description {
    NSMutableString * str = [[NSMutableString alloc] init];
    [str appendFormat:@"City Name: %@\n", self.name];
    
    for (Weather * w in self.weathers) {
        [str appendFormat:@"%@\n", [w description]];
    }
    return [str description];
}

- (BOOL) isEqual:(id) other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToCity:other];
}

- (BOOL) isEqualToCity: (City *) other {
    if (self == other)
        return YES;
    if (![[self.name lowercaseString] isEqualToString:[other.name lowercaseString]])
        return NO;
    return YES;
}
@end
