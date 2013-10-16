//
//  Weather.h
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property NSDate * date;
@property NSNumber * tempMaxC;
@property NSNumber * tempMinC;
@property NSNumber * precipMM;
@property NSNumber * windSpeedKmph;
@property NSNumber * windDirDegree;
@property (strong) NSString * desc;

- (id) initWithDate: (NSString*) strDate
           tempMaxC: (int) max
           tempMinC: (int) min
           precipMM: (float) precip
      windSpeedKmph: (int) speed
      windDirDegree: (int) dir
               desc: (NSString *) d;
@end
