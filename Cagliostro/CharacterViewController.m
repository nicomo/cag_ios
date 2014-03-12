//
//  CharacterViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 19/02/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "CharacterViewController.h"

@interface CharacterViewController ()

@end

@implementation CharacterViewController

- (id)init
{
    self = [super init];
    self.cid = 0;
    return self;
}

- (id)initWithCid:(int) cid
{
    self = [super init];
    self.cid = cid;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    self.navigationItem.title = [chardata[self.cid] objectForKey:@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
