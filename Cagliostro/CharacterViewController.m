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
#import "CharacterCell.h"
#import "ConfessionsViewController.h"

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
    
    [self addConfessions];
    
    UILabel *friendslabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 668, 25)];
    [friendslabel setText:@"Mes connaissances"];
    [friendslabel setFont:[UIFont fontWithName:@"Georgia" size:25]];
    CSLinearLayoutItem *flitem = [CSLinearLayoutItem layoutItemForView:friendslabel];
    flitem.padding = CSLinearLayoutMakePadding(50, 50, 0, 50);
    [mainLinearLayout addItem:flitem];
    
    [self addFriends];
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

- (void)addFriends
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(324, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.charcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 668,
                                                                     110 * (int)(([[chardata[self.cid] objectForKey:@"friends"] count]+1) / 2)
                                                                     ) collectionViewLayout:layout];
    self.charcv.backgroundColor = [UIColor clearColor];
    self.charcv.delegate = self;
    self.charcv.dataSource = self;
    self.charcv.showsVerticalScrollIndicator = NO;
    self.charcv.scrollEnabled = NO;
    [self.charcv registerClass:[CharacterCell class] forCellWithReuseIdentifier:@"CharacterCell"];
    
    CSLinearLayoutItem *friendsitem = [CSLinearLayoutItem layoutItemForView:self.charcv];
    friendsitem.padding = CSLinearLayoutMakePadding(25, 50, 50, 50);
    [mainLinearLayout addItem:friendsitem];
}

- (void)addConfessions
{
    self.confpages = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSDictionary *qr in confdata) {
        ConfessionsViewController *pvc = [[ConfessionsViewController alloc] init];
        pvc.pageindex = i;

        UILabel *q = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 309, 20)];
        [q setText:[qr objectForKey:@"question"]];
        [q setFont:[UIFont fontWithName:@"georgia" size:20]];
        q.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
        q.userInteractionEnabled = NO;
        q.numberOfLines = 1;
        
        [pvc.view addSubview:q];
        
        
        
        [self.confpages addObject:pvc];
        i++;
    }
    
    self.confpvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.confpvc.view.backgroundColor = [UIColor redColor];
    self.confpvc.view.frame = CGRectMake(0, 0, 309, 300);
    self.confpvc.dataSource = self;
    self.confpvc.delegate = self;

    [self.confpvc setViewControllers:@[[self.confpages objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    CSLinearLayoutItem *confitem = [CSLinearLayoutItem layoutItemForView:self.confpvc.view];
    confitem.padding = CSLinearLayoutMakePadding(50, 50, 0, 50);
    [mainLinearLayout addItem:confitem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [[chardata[self.cid] objectForKey:@"friends"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CharacterCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CharacterCell" forIndexPath:indexPath];
    int cid = [[[chardata[self.cid] objectForKey:@"friends"] objectAtIndex:indexPath.row] intValue];
    if ([self published:cid]) {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"character%d", cid]];
        cell.title.text = [chardata[cid] objectForKey:@"name"];
    } else {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"anon%@", [chardata[cid] objectForKey:@"gender"]]];
        cell.title.text = @"À paraître";
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    int cid = [[[chardata[self.cid] objectForKey:@"friends"] objectAtIndex:indexPath.row] intValue];
    if ([self published:cid]) {
        CharacterViewController *cvc = [[CharacterViewController alloc] initWithCid:cid];
        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [(UINavigationController *)ad.window.rootViewController pushViewController:cvc animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)cv shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)cv shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

- (int)epidforcid:(int) cid
{
    return [[chardata[cid] objectForKey:@"epid"] intValue];
}

- (BOOL)published:(int) cid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    return !delayedEps || [self epidforcid:cid] < minElapsed;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ConfessionsViewController*) viewController).pageindex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.confpages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ConfessionsViewController*) viewController).pageindex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.confpages count] == 0) || (index >= [self.confpages count])) {
        return nil;
    }
    
    return [self.confpages objectAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.confpages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
