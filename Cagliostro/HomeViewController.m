//
//  HomeViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleCell.h"

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    episodesExpanded = NO;
    episodesHeight = 300;
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
    return 5;
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
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"TOUS LES EPISODES";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 335;
    } else if (indexPath.row == 1) {
        return episodesHeight;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        if (episodesExpanded) {
            episodesHeight = 300;
            episodesExpanded = NO;
        } else {
            episodesHeight = 500;
            episodesExpanded = YES;
        }
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

@end
