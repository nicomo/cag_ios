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
    
    // First textzone
    
    CSLinearLayoutView *ll1 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, 668, 100)];
    ll1.autoresizesSubviews = YES;
    ll1.orientation = CSLinearLayoutViewOrientationHorizontal;
    
    UIImageView *bullhorn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [bullhorn setImage:[UIImage imageNamed:@"bullhorn"]];
    CSLinearLayoutItem *bhitem = [CSLinearLayoutItem layoutItemForView:bullhorn];
    [ll1 addItem:bhitem];
    
    UITextView *intro = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 309, 100)];
    [intro setText:[pldata[self.plid] objectForKey:@"intro"]];
    [intro setFont:[UIFont fontWithName:@"Georgia" size:12]];
    intro.backgroundColor = [UIColor clearColor];
    intro.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    [intro sizeToFit];
    CSLinearLayoutItem *introitem = [CSLinearLayoutItem layoutItemForView:intro];
    [ll1 addItem:introitem];
    
    CSLinearLayoutView *llv1 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, 309, 0)];
    llv1.autoAdjustFrameSize = YES;
    llv1.orientation = CSLinearLayoutViewOrientationVertical;
    
    for (int i = 0; i < 3; i++) {
        
        CSLinearLayoutView *lli1 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, 309, 40)];
        lli1.autoAdjustFrameSize = YES;
        lli1.orientation = CSLinearLayoutViewOrientationHorizontal;
        
        UIImageView *iticon1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [iticon1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"itin_%d", i]]];
        CSLinearLayoutItem *iticon1item = [CSLinearLayoutItem layoutItemForView:iticon1];
        [lli1 addItem:iticon1item];
        
        UITextView *itin1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 309-20-40, 0)];
        itin1.text = [[pldata[self.plid] objectForKey:@"itineraire"] objectAtIndex:i];
        itin1.font = [UIFont fontWithName:@"Georgia" size:12];
        itin1.backgroundColor = [UIColor clearColor];
        itin1.textContainerInset = UIEdgeInsetsMake(5,5,5,5);
        [itin1 sizeToFit];
        itin1.frame = CGRectMake(0, 0, 309-20-40, itin1.frame.size.height);
        CSLinearLayoutItem *itin1item = [CSLinearLayoutItem layoutItemForView:itin1];
        [lli1 addItem:itin1item];
        
        CSLinearLayoutItem *lli1item = [CSLinearLayoutItem layoutItemForView:lli1];
        lli1item.padding = CSLinearLayoutMakePadding(10, 10, 0, 10);
        [llv1 addItem:lli1item];
    }
    
    UITextView *histotitle = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 309, 0)];
    histotitle.text = @"HISTORIQUE";
    histotitle.font = [UIFont fontWithName:@"Georgia" size:12];
    histotitle.backgroundColor = [UIColor clearColor];
    histotitle.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    histotitle.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    histotitle.layer.borderWidth = 1;
    [histotitle sizeToFit];
    histotitle.frame = CGRectMake(0, 0, 309, histotitle.frame.size.height);
    CSLinearLayoutItem *htitem = [CSLinearLayoutItem layoutItemForView:histotitle];
    htitem.padding = CSLinearLayoutMakePadding(15, 0, 0, 0);
    [llv1 addItem:htitem];
    
    UITextView *historique = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 309, 0)];
    historique.text = [pldata[self.plid] objectForKey:@"historique"];
    historique.font = [UIFont fontWithName:@"Georgia" size:12];
    historique.backgroundColor = [UIColor clearColor];
    historique.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    historique.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    historique.layer.borderWidth = 1;
    [historique sizeToFit];
    historique.frame = CGRectMake(0, 0, 309, historique.frame.size.height);
    CSLinearLayoutItem *hitem = [CSLinearLayoutItem layoutItemForView:historique];
    [llv1 addItem:hitem];
    
    CSLinearLayoutItem *llv1item = [CSLinearLayoutItem layoutItemForView:llv1];
    [ll1 addItem:llv1item];
    
    if (intro.frame.size.height > ll1.frame.size.height)
        ll1.frame = CGRectMake(0, 0, 668, intro.frame.size.height);
    if (llv1.frame.size.height > ll1.frame.size.height)
        ll1.frame = CGRectMake(0, 0, 668, llv1.frame.size.height);
    
    CSLinearLayoutItem *ll1item = [CSLinearLayoutItem layoutItemForView:ll1];
    ll1item.padding = CSLinearLayoutMakePadding(0, 50, 50, 50);
    [mainLinearLayout addItem:ll1item];
    
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
