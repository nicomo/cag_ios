//
//  PlaceViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 30/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "PlaceViewController.h"
#import "AppDelegate.h"
#import "CSLinearLayoutView.h"

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

CSLinearLayoutView *mainLinearLayout;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    // create the linear layout view
    mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    mainLinearLayout.backgroundColor = [UIColor clearColor];
    mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:mainLinearLayout];
    
    self.navigationItem.title = [pldata[self.plid] objectForKey:@"name"];
    
    self.map = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768 - (85*2), 428)];
    
    UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768 - (85*2), 428)];
    mapimg.image = [UIImage imageNamed:@"map"];
    [self.map addSubview:mapimg];
    
    CSLinearLayoutItem *mapitem = [CSLinearLayoutItem layoutItemForView:self.map];
    mapitem.padding = CSLinearLayoutMakePadding(0, 85, 40, 85);
    [mainLinearLayout addItem:mapitem];
    
    NSMutableDictionary *place = pldata[self.plid];
    double x = [[place objectForKey:@"x"] doubleValue];
    double y = [[place objectForKey:@"y"] doubleValue];
    UIButton* placebtn = [[UIButton alloc] initWithFrame:CGRectMake((x*598) - 20, (y*428) - 20, 40, 40)];
    if (self.plid < 7) {
        [placebtn setBackgroundImage:[UIImage imageNamed:@"place_abbey"] forState:UIControlStateNormal];
    } else {
        [placebtn setBackgroundImage:[UIImage imageNamed:@"place_other"] forState:UIControlStateNormal];
    }
    placebtn.tag = self.plid;
    [self.map addSubview:placebtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
