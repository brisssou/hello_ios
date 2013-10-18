//
//  ViewController.m
//  Weather
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "MasterViewController.h"
#import "WeatherDataController.h"
#import "DetailViewController.h"
#import "City.h"
#import "Weather.h"

@interface MasterViewController ()
@property WeatherDataController * data;
@property UIPopoverController * popOver;
@property DetailViewController * detail;
@end

@implementation MasterViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setData:[WeatherDataController getInstance]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityAddedNotification:)
                                                     name:@"cityAdded"
                                                   object:Nil];
    }
    return self;
}

//have to be there, because we have a popover launched from a uibarbutton
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
        
        [self closePopover];
        
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
    [self closePopover];}

- (void)closePopover {
    [self.popOver dismissPopoverAnimated:YES];
    self.popOver = nil;
}

//unwind segue, for cancel button
- (IBAction) returned: (UIStoryboardSegue *) segue {
    [self closePopover];
    
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
    self.detail = self.splitViewController.viewControllers[1];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
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
    City * city = [self.data.cities objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[city name]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detail.city = [self.data cities][indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeCityAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:(UITableViewRowAnimationFade)];
    }
}
@end
