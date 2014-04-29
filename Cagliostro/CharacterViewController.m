//
//  CharacterViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 19/02/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "CharacterViewController.h"
#import "CSLinearLayoutView.h"

@interface CharacterViewController ()

@end

CSLinearLayoutView *mainLinearLayout;

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
    
    // create the linear layout view
    mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    mainLinearLayout.backgroundColor = [UIColor clearColor];
    mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:mainLinearLayout];
    
    [self addHeader];
}

- (void)addHeader
{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 400)];
    [header setImage:[UIImage imageNamed:@"charbg"]];
    
    UIView *whitestripe = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 768, 200)];
    [whitestripe setBackgroundColor:[UIColor whiteColor]];
    [whitestripe setAlpha:0.5];
    [header addSubview:whitestripe];
    
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    [avatar setImage:[UIImage imageNamed:[NSString stringWithFormat:@"character%d", self.cid]]];
    [header addSubview:avatar];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50+100+50, 250, 400, 100)];
    [name setText:[chardata[self.cid] objectForKey:@"name"]];
    [name setFont:[UIFont fontWithName:@"SuperClarendon-Black" size:30]];
    name.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    name.userInteractionEnabled = NO;
    name.numberOfLines = 2;
    [header addSubview:name];
    
    CSLinearLayoutItem *headeritem = [CSLinearLayoutItem layoutItemForView:header];
    [mainLinearLayout addItem:headeritem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
