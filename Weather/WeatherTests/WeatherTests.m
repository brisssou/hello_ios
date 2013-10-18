//
//  WeatherTests.m
//  WeatherTests
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Weather.h"
#import "City.h"
#import "WeatherNetworkController.h"
#import "WeatherDataController.h"

@interface WeatherTests : XCTestCase

@end

@implementation WeatherTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [NSThread sleepForTimeInterval: .1];
}

- (void)testExample
{
    Weather * w = [[Weather alloc] initWithDate:@"2013-11-10"
                                       tempMaxC:0
                                       tempMinC:0
                                       precipMM:0.
                                  windSpeedKmph:0
                                  windDirDegree:0
                                           desc:@""];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[w date]]; // Get necessary date components
    
    XCTAssertEqual(2013, [components year]);
    XCTAssertEqual(11, [components month]);
    XCTAssertEqual(10, [components day]);
}

//- (void) testSingleton
//{
//    WeatherDataController * ctrl = [WeatherDataController getInstance];
//    WeatherDataController * other = [WeatherDataController getInstance];
//    XCTAssertEqual(ctrl, other);
//    XCTAssertEqual(0u, [[ctrl cities] count]);
//    NSError * error;
//    [ctrl addCityWithName:@"city" addError: &error];
//    XCTAssertEqual(1u, [[ctrl cities] count]);
//}

- (void) testDesc {
    City * c = [[City alloc] initWithName:@"Là-bas"];
    [c.weathers addObject:[[Weather alloc]initWithDate:@"2013-10-11"
                                              tempMaxC:42
                                              tempMinC:-666
                                              precipMM:12.
                                         windSpeedKmph:31
                                         windDirDegree:45
                                                  desc:@"C'est vraiment très intéressant"]];
    NSLog(@"\n%@", [c description]);
}

//- (void) testCitySorted {
//    WeatherDataController * ctrl = [WeatherDataController getInstance];
//    [ctrl addCityWithName:@"zity" addError:nil];
//    [ctrl addCityWithName:@"city" addError:nil];
//    [ctrl addCityWithName:@"aity" addError:nil];
//    XCTAssertEqual(@"aity", [[ctrl.cities objectAtIndex:0] name]);
//    XCTAssertEqual(@"city", [[ctrl.cities objectAtIndex:1] name]);
//    XCTAssertEqual(@"zity", [[ctrl.cities objectAtIndex:2] name]);
//}
//
//- (void) testWeatherService {
// // TODO Hard to test asynch code...
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    [WeatherNetworkController  requestWeathersForCityName:@"Grenoble"
//                                               completion:^(NSArray * weathers, NSString * error){
//                                                   dispatch_semaphore_signal(sem);
//                                                   NSLog(error);
//                                               }];
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    
//}
@end
