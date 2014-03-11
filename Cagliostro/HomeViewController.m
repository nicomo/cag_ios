//
//  HomeViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleCell.h"
#import "EpisodesCell.h"
#import "MapCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    episodesExpanded = NO;
    episodesHeight = 490;
    
    self.navigationItem.title = @"LE JOURNAL";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    if (indexPath.row == 0) {
        TitleCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (cell == nil) {
            cell = [[TitleCell alloc] initWithFrame:CGRectZero];
        }
        return cell;
    } else if (indexPath.row == 1) {
        EpisodesCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (cell == nil) {
            cell = [[EpisodesCell alloc] initWithFrame:CGRectZero];
        }
        return cell;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"TOUS LES EPISODES";
    } else if (indexPath.row == 3) {
        MapCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell"];
        if (cell == nil) {
            cell = [[MapCell alloc] initWithFrame:CGRectZero];
        }
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 335;
    } else if (indexPath.row == 1) {
        return episodesHeight;
    } else if (indexPath.row == 3) {
        return 620;
    }
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        if (episodesExpanded) {
            episodesHeight = 490;
            episodesExpanded = NO;
        } else {
            episodesHeight = 1450;
            episodesExpanded = YES;
        }
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

@end
