//
//  AddCityPopOverViewController.h
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddCityPopOverViewController;

@protocol addCityDelegate
- (void) cityAdded: (AddCityPopOverViewController *) sender;
@end


@interface AddCityPopOverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) id<addCityDelegate> delegate;

- (IBAction)doneClicked:(id)sender;


@end


