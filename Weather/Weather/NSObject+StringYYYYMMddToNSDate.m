//
//  NSObject+StringYYYYMMddToNSDate.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "NSObject+StringYYYYMMddToNSDate.h"

@implementation NSString (StringYYYYMMddToNSDate)

- (NSDate*) toDate {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:self];
}
@end
