//
//  WeathersCollectionViewController.h
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface WeathersCollectionViewController : UICollectionViewController <UICollectionViewDataSource>
@property (weak,nonatomic) City * city;
@end
