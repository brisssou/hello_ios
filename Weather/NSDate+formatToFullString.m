//
//  NSDate+formatToFullString.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "NSDate+formatToFullString.h"

@implementation NSDate (formatToFullString)
- (NSString *)formatToFullString{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterFullStyle ];
    return [df stringFromDate:self];}
@end
