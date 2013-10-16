//
//  BigViewController.h
//  hello
//
//  Created by admin on 14/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigViewController : UIViewController {
@public NSString * toDisplay;
}
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@end
