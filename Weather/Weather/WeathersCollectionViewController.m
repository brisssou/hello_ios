//
//  WeathersCollectionViewController.m
//  Weather
//
//  Created by admin on 16/10/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "WeathersCollectionViewController.h"
#import "WeatherCell.h"

@interface WeathersCollectionViewController ()

@end

@implementation WeathersCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setCity:(City *)city {
    _city = city;
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCell * weatherCell =
    [self.collectionView dequeueReusableCellWithReuseIdentifier:@"weatherCell" forIndexPath:indexPath];
    [weatherCell setWeather: self.city.weathers[[indexPath row]]];
    return weatherCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.city.weathers count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
