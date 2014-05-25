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
        itin1.userInteractionEnabled = NO;
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
    
    // Bottom textzones
    
    CSLinearLayoutView *ll2 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, 668, 100)];
    ll2.orientation = CSLinearLayoutViewOrientationHorizontal;
    
    CSLinearLayoutView *llv2 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
    llv2.autoAdjustFrameSize = YES;
    llv2.orientation = CSLinearLayoutViewOrientationVertical;
    
    UITextView *celebstitle = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
    celebstitle.text = @"CELEBRITES";
    celebstitle.font = [UIFont fontWithName:@"Georgia" size:12];
    celebstitle.backgroundColor = [UIColor clearColor];
    celebstitle.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    celebstitle.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    celebstitle.layer.borderWidth = 1;
    [celebstitle sizeToFit];
    celebstitle.userInteractionEnabled = NO;
    celebstitle.frame = CGRectMake(0, 0, (668/2)-13, celebstitle.frame.size.height);
    CSLinearLayoutItem *ctitem = [CSLinearLayoutItem layoutItemForView:celebstitle];
    [llv2 addItem:ctitem];
    
    CSLinearLayoutView *llvc = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
    llvc.autoAdjustFrameSize = YES;
    llvc.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    llvc.layer.borderWidth = 1;
    llvc.orientation = CSLinearLayoutViewOrientationVertical;
    
    for (NSString *cs in [pldata[self.plid] objectForKey:@"celebs"]) {
        UITextView *celeb = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
        celeb.text = cs;
        celeb.font = [UIFont fontWithName:@"Georgia" size:12];
        celeb.backgroundColor = [UIColor clearColor];
        celeb.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
        [celeb sizeToFit];
        celeb.userInteractionEnabled = NO;
        celeb.frame = CGRectMake(0, 0, (668/2)-13, celeb.frame.size.height);
        CSLinearLayoutItem *citem = [CSLinearLayoutItem layoutItemForView:celeb];
        [llvc addItem:citem];
    }
    
    CSLinearLayoutItem *llvcitem = [CSLinearLayoutItem layoutItemForView:llvc];
    llvcitem.padding = CSLinearLayoutMakePadding(0, 0, 0, 13);
    [llv2 addItem:llvcitem];
    
    UITextView *convtitle = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
    convtitle.text = @"GUIDE DE CONVERSATION";
    convtitle.font = [UIFont fontWithName:@"Georgia" size:12];
    convtitle.backgroundColor = [UIColor clearColor];
    convtitle.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    convtitle.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    convtitle.layer.borderWidth = 1;
    [convtitle sizeToFit];
    convtitle.frame = CGRectMake(0, 0, (668/2)-13, convtitle.frame.size.height);
    CSLinearLayoutItem *convtitem = [CSLinearLayoutItem layoutItemForView:convtitle];
    convtitem.padding = CSLinearLayoutMakePadding(25, 0, 0, 0);
    [llv2 addItem:convtitem];
    
    CSLinearLayoutView *llvconv = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
    llvconv.autoAdjustFrameSize = YES;
    llvconv.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    llvconv.layer.borderWidth = 1;
    llvconv.orientation = CSLinearLayoutViewOrientationVertical;
    
    for (NSString *cs in [pldata[self.plid] objectForKey:@"conversation"]) {
        UITextView *conv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-13, 0)];
        conv.text = cs;
        conv.font = [UIFont fontWithName:@"Georgia" size:12];
        conv.backgroundColor = [UIColor clearColor];
        conv.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
        [conv sizeToFit];
        conv.userInteractionEnabled = NO;
        conv.frame = CGRectMake(0, 0, (668/2)-13, conv.frame.size.height);
        CSLinearLayoutItem *citem = [CSLinearLayoutItem layoutItemForView:conv];
        [llvconv addItem:citem];
    }
    
    CSLinearLayoutItem *llvconvitem = [CSLinearLayoutItem layoutItemForView:llvconv];
    llvconvitem.padding = CSLinearLayoutMakePadding(0, 0, 0, 13);
    [llv2 addItem:llvconvitem];
    
    CSLinearLayoutItem *llv2item = [CSLinearLayoutItem layoutItemForView:llv2];
    llv2item.padding = CSLinearLayoutMakePadding(0, 0, 0, 13);
    [ll2 addItem:llv2item];
    
    CSLinearLayoutView *llv3 = [[CSLinearLayoutView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-12, 0)];
    llv3.autoAdjustFrameSize = YES;
    llv3.orientation = CSLinearLayoutViewOrientationVertical;
    
    UITextView *savoirtitle = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-12, 0)];
    savoirtitle.text = @"LE SAVIEZ-VOUS ?";
    savoirtitle.font = [UIFont fontWithName:@"Georgia" size:12];
    savoirtitle.backgroundColor = [UIColor clearColor];
    savoirtitle.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    savoirtitle.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    savoirtitle.layer.borderWidth = 1;
    [savoirtitle sizeToFit];
    savoirtitle.frame = CGRectMake(0, 0, (668/2)-12, savoirtitle.frame.size.height);
    CSLinearLayoutItem *stitem = [CSLinearLayoutItem layoutItemForView:savoirtitle];
    [llv3 addItem:stitem];
    
    UITextView *savoir = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (668/2)-12, 0)];
    savoir.text = [pldata[self.plid] objectForKey:@"savoir"];
    savoir.font = [UIFont fontWithName:@"Georgia" size:12];
    savoir.backgroundColor = [UIColor clearColor];
    savoir.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    savoir.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    savoir.layer.borderWidth = 1;
    [savoir sizeToFit];
    savoir.frame = CGRectMake(0, 0, (668/2)-12, savoir.frame.size.height);
    CSLinearLayoutItem *sitem = [CSLinearLayoutItem layoutItemForView:savoir];
    [llv3 addItem:sitem];
    
    if (llv2.frame.size.height > ll2.frame.size.height)
        ll2.frame = CGRectMake(0, 0, 668, llv2.frame.size.height);
    if (llv3.frame.size.height > ll2.frame.size.height)
        ll2.frame = CGRectMake(0, 0, 668, llv3.frame.size.height);
    
    CSLinearLayoutItem *llv3item = [CSLinearLayoutItem layoutItemForView:llv3];
    llv3item.padding = CSLinearLayoutMakePadding(0, 12, 0, 0);
    [ll2 addItem:llv3item];
    
    CSLinearLayoutItem *ll2item = [CSLinearLayoutItem layoutItemForView:ll2];
    ll2item.padding = CSLinearLayoutMakePadding(0, 50, 50, 50);
    [mainLinearLayout addItem:ll2item];
    
    UITextView *eventstitle = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 668, 0)];
    eventstitle.text = @"EVENEMENTS LOCAUX";
    eventstitle.font = [UIFont fontWithName:@"Georgia" size:12];
    eventstitle.backgroundColor = [UIColor clearColor];
    eventstitle.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    eventstitle.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    eventstitle.layer.borderWidth = 1;
    [eventstitle sizeToFit];
    eventstitle.frame = CGRectMake(0, 0, 668, eventstitle.frame.size.height);
    CSLinearLayoutItem *etitem = [CSLinearLayoutItem layoutItemForView:eventstitle];
    etitem.padding = CSLinearLayoutMakePadding(0, 50, 0, 50);
    [mainLinearLayout addItem:etitem];
    
    UITextView *events = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 668, 0)];
    events.text = [pldata[self.plid] objectForKey:@"events"];
    events.font = [UIFont fontWithName:@"Georgia" size:12];
    events.backgroundColor = [UIColor clearColor];
    events.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
    events.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
    events.layer.borderWidth = 1;
    [events sizeToFit];
    events.frame = CGRectMake(0, 0, 668, events.frame.size.height);
    CSLinearLayoutItem *eitem = [CSLinearLayoutItem layoutItemForView:events];
    eitem.padding = CSLinearLayoutMakePadding(0, 50, 50, 50);
    [mainLinearLayout addItem:eitem];
    
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
