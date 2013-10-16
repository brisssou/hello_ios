//
//  ViewController.m
//  hello
//
//  Created by admin on 14/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "ViewController.h"
#import "BigViewController.h"

@interface ViewController ()
- (void) displayMessage;
- (IBAction)sayNameClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UILabel *bigLbl;
@end

@implementation ViewController

- (NSString*) getMessage {
    NSString * name = [self.nameTxt text];
    if (name.length == 0)
        name = @"World";
    NSString* msg = [NSString stringWithFormat: @"Hello, %@!", name];
    return msg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayMessage {
    [self.bigLbl setText: [self getMessage]];
}
- (IBAction)sayNameClicked:(id)sender {
    
    [self displayMessage];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (([segue.identifier isEqualToString: @"pushToBig"])) {
        BigViewController * big = segue.destinationViewController;
        big->toDisplay = [self getMessage];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTxt) {
        [self displayMessage];
        [textField resignFirstResponder];
    }
    return YES;
}
@end
