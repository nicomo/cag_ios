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
#import "PhotoViewController.h"

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
    
    // Slideshow

    self.photopages = [[NSMutableArray alloc] init];
    int j = 0;
    for (int i = 0; i < [[pldata[self.plid] objectForKey:@"numphotos"] integerValue]; i++) {
        PhotoViewController *pvc = [[PhotoViewController alloc] init];
        pvc.pageindex = j;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 488)];
        [img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"place_%d_image_%d", self.plid, i]]];
        [pvc.view addSubview:img];
        [self.photopages addObject:pvc];
        j++;
    }
    
    self.photopvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.photopvc.view.frame = CGRectMake(0, 0, 768, 488);
    self.photopvc.dataSource = self;
    self.photopvc.delegate = self;
    
    [self.photopvc setViewControllers:@[[self.photopages objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    CSLinearLayoutItem *photoitem = [CSLinearLayoutItem layoutItemForView:self.photopvc.view];
    [mainLinearLayout addItem:photoitem];
    
    // Title
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 668, 100)];
    [name setText:[pldata[self.plid] objectForKey:@"name"]];
    [name setFont:[UIFont fontWithName:@"SuperClarendon-Black" size:30]];
    name.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    name.userInteractionEnabled = NO;
    name.numberOfLines = 2;
    
    CSLinearLayoutItem *headeritem = [CSLinearLayoutItem layoutItemForView:name];
    headeritem.padding = CSLinearLayoutMakePadding(0, 50, 0, 50);
    [mainLinearLayout addItem:headeritem];
    
    // Map
    
    self.map = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668, 476)];
    
    UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 668, 476)];
    mapimg.image = [UIImage imageNamed:@"map"];
    [self.map addSubview:mapimg];
    
    CSLinearLayoutItem *mapitem = [CSLinearLayoutItem layoutItemForView:self.map];
    mapitem.padding = CSLinearLayoutMakePadding(0, 50, 50, 50);
    [mainLinearLayout addItem:mapitem];
    
    NSMutableDictionary *place = pldata[self.plid];
    double x = [[place objectForKey:@"x"] doubleValue];
    double y = [[place objectForKey:@"y"] doubleValue];
    UIButton* placebtn = [[UIButton alloc] initWithFrame:CGRectMake((x*668) - 20, (y*476) - 20, 40, 40)];
    if (self.plid < 7) {
        [placebtn setBackgroundImage:[UIImage imageNamed:@"place_abbey"] forState:UIControlStateNormal];
    } else {
        [placebtn setBackgroundImage:[UIImage imageNamed:@"place_other"] forState:UIControlStateNormal];
    }
    placebtn.tag = self.plid;
    [self.map addSubview:placebtn];
    
    // Bottom images
    
    UIView *bic = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668, 400)];
    
    UIImageView *ib1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 400)];
    [ib1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"place_%d_imagebottom_0", self.plid]]];
    [bic addSubview:ib1];
    
    UIImageView *ib2 = [[UIImageView alloc] initWithFrame:CGRectMake((668/2)+12, 0, (668/2)-12, 400)];
    [ib2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"place_%d_imagebottom_1", self.plid]]];
    [bic addSubview:ib2];
    
    CSLinearLayoutItem *biitem = [CSLinearLayoutItem layoutItemForView:bic];
    biitem.padding = CSLinearLayoutMakePadding(0, 50, 50, 50);
    [mainLinearLayout addItem:biitem];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PhotoViewController*) viewController).pageindex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.photopages count]) {
        return nil;
    }
    if (([self.photopages count] == 0) || (index >= [self.photopages count])) {
        return nil;
    }
    
    return [self.photopages objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PhotoViewController*) viewController).pageindex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    if (([self.photopages count] == 0) || (index >= [self.photopages count])) {
        return nil;
    }
    
    return [self.photopages objectAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.photopages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
