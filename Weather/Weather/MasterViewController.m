//
//  ViewController.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "MasterViewController.h"
#import "WeatherDataController.h"

@interface MasterViewController ()
@property WeatherDataController * data;
@property UIPopoverController * popOver;
@end

@implementation MasterViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setData:[WeatherDataController getInstance]];
        NSError * error;
        [self.data addCityWithName:@"Grenoble" addError:&error];
        [self.data addCityWithName:@"pwet" addError:&error];
        [self.data addCityWithName:@"coin" addError:&error];
        [self.data addCityWithName:@"labas" addError:&error];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityAddedNotification:)
                                                     name:@"cityAdded"
                                                   object:Nil];
    }
    return self;
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return ![identifier isEqualToString:@"openPopOverSegue"] || self.popOver == nil;
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"Dismissed popover");
    self.popOver = nil;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIStoryboardPopoverSegue * popSegue = (UIStoryboardPopoverSegue *) segue;
    if ([[segue identifier] isEqualToString:@"openPopOverSegue"]) {
        NSLog(@"segue prepared");
        
        [self.popOver dismissPopoverAnimated:YES];
        
        [self setPopOver: [popSegue popoverController]];
        [self.popOver setDelegate:self];
        [segue.destinationViewController setDelegate:self];
    }
}

- (void) cityAddedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"cityAdded"]) {
        [self.tableView reloadData];
    }
}

- (void) cityAdded:(AddCityPopOverViewController *)sender {
    [self.popOver dismissPopoverAnimated:YES];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.textLabel setText:[[self.data.cities objectAtIndex:[indexPath row]] name]];
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
