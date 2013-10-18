//
//  CityCell.h
//  Weather
//
//  Created by admin on 18/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface CityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityName;
- (IBAction)updateButtonClicked:(id)sender;
@end
