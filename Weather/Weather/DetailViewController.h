//
//  DetailViewController.h
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
@property (nonatomic) City * city;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (nonatomic) UIPopoverController *masterPopoverController;
@end
