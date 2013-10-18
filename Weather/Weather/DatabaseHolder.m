//
//  DatabaseHolder.m
//  Weather
//
//  Created by admin on 17/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "DatabaseHolder.h"
#import "FMDatabase.h"
#import "Weather.h"
@interface DatabaseHolder ()
@property FMDatabase * db;
@end

@implementation DatabaseHolder
NSString * DB_PATH = @"weather.sqlite";
+ (FMDatabase *)getDB {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString * libDir = paths[0];
    
    NSString * dbPath = [libDir stringByAppendingPathComponent:DB_PATH];
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    
    NSBundle * bundle =  [NSBundle mainBundle];
    
    if (![fileMgr fileExistsAtPath:dbPath]) {
        NSError * error;
        if (![fileMgr copyItemAtPath:[bundle pathForResource:DB_PATH ofType:@""] toPath:dbPath error:&error]) {
            NSLog(@"error %@ ", error.localizedDescription);
        }
    }
    
    
    
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"No DB");
    }
    return db;
}

- (id)init {
    if (self = [super init])
        self.db = [DatabaseHolder getDB];
    return self;
}

-(BOOL)addCity:(City *)city withError:(NSError **) error{
    [self.db beginTransaction];
    if (![self.db executeUpdate:@"INSERT INTO CITY (NAME) VALUES (?)", city.name]) {
        NSLog(@"DB error %@", [self.db lastErrorMessage]);
        *error = self.db.lastError;
        return NO;
    };
    [self.db commit];

    return YES;
}

- (BOOL)setWeathers:(NSArray *)weathers forCity:(City *)city withError:(NSError *__autoreleasing *)error {
    return [self setWeathers:weathers forCityName:city.name withError:error];
}

- (BOOL)setWeathers:(NSArray *)weathers forCityName:(NSString *)cityName withError:(NSError *__autoreleasing *)error {
    [self.db beginTransaction];
    
    [self.db executeUpdate:@"DELETE FROM WEATHER WHERE CITYNAME = ?", cityName];
    
    for (Weather * weather in weathers){
        [self.db executeUpdate:@"INSERT INTO WEATHER"
         "(CITYNAME,"
         " DATE,"
         " TEMPMAX,"
         " TEMPMIN,"
         " PRECIPITATION,"
         " WINDSPEED,"
         " WINDDIRECTION,"
         " DESC) "
         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
         cityName,
         weather.date,
         weather.tempMaxC,
         weather.tempMinC,
         weather.precipMM,
         weather.windSpeedKmph,
         weather.windDirDegree,
         weather.desc
         ];
    }
    
    
    [self.db commit];
    return YES;
}

- (NSArray *)getCities {
    NSMutableArray * cities = [[NSMutableArray alloc] init];
    FMResultSet * res = [self.db executeQuery:@"SELECT NAME FROM CITY"];
    while ([res next]){
        [cities addObject:[[City alloc]initWithName:[res stringForColumn:@"NAME"]]];
    }
    return cities;
}

- (NSArray *)getWeathersForCity:(City *)city {
    NSMutableArray * weathers = [[NSMutableArray alloc] init];
    FMResultSet * res = [self.db executeQuery:@"SELECT DATE,"
                         " TEMPMAX,"
                         " TEMPMIN,"
                         " PRECIPITATION,"
                         " WINDSPEED,"
                         " WINDDIRECTION,"
                         " DESC FROM WEATHER WHERE CITYNAME = ?",
                         city.name];
    while ([res next]){
        [weathers addObject:[[Weather alloc] initWithRealDate:[res dateForColumn:@"DATE"]
                                                     tempMaxC:[res  intForColumn:@"TEMPMIN"]
                                                     tempMinC:[res intForColumn:@"TEMPMAX"]
                                                     precipMM:[res doubleForColumn:@"PRECIPITATION"]
                                                windSpeedKmph:[res intForColumn:@"WINDSPEED"]
                                                windDirDegree:[res intForColumn:@"WINDDIRECTION"]
                                                         desc:[res stringForColumn:@"DESC"]]];
    }
    return weathers;
}

- (BOOL)removeCity:(City *)city withError:(NSError *__autoreleasing *)error {
    
    [self.db beginTransaction];
    
    [self.db executeUpdate:@"DELETE FROM WEATHER WHERE CITYNAME = ?", city.name];
    [self.db executeUpdate:@"DELETE FROM CITY WHERE NAME = ?", city.name];
        
    [self.db commit];
    return YES;

}
@end
