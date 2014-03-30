//
//  PlaceViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 30/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "PlaceViewController.h"
#import "AppDelegate.h"

@interface PlaceViewController ()

@end

@implementation PlaceViewController

- (id)init
{
    self = [super init];
    self.plid = 0;
    return self;
}

- (id)initWithPlid:(int) plid
{
    self = [super init];
    self.plid = plid;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    self.navigationItem.title = [pldata[self.plid] objectForKey:@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
