//
//  WeatherCell.h
//  Weather
//
//  Created by admin on 17/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface WeatherCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *windDirImg;
@property (weak, nonatomic) IBOutlet UILabel *precipitationLabel;

@property (weak,nonatomic) Weather * weather;
@end
