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
#import "MessagesViewController.h"

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
    
    [self addConfessionsAndMessages];
    
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

- (void)addConfessionsAndMessages
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668, 300)];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 304, 50)];
    [l setText:@"Confessions"];
    [l setFont:[UIFont fontWithName:@"georgia" size:25]];
    l.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    l.userInteractionEnabled = NO;
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(359+5, 0, 304, 50)];
    [l2 setText:@"Messages"];
    [l2 setFont:[UIFont fontWithName:@"georgia" size:25]];
    l2.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    l2.userInteractionEnabled = NO;
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(5, 50, 299, 2)];
    sep.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    UIView *sep3 = [[UIView alloc] initWithFrame:CGRectMake(359+5, 50, 299, 2)];
    sep3.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    self.confpages = [[NSMutableArray alloc] init];
    int j = 0;
    for (int i = 0; i < [confdata count]; i = i + 2) {
        ConfessionsViewController *pvc = [[ConfessionsViewController alloc] init];
        pvc.pageindex = j;
        [pvc.view addSubview:pvc.mainLinearLayout];
        NSDictionary *qr1 = [confdata objectAtIndex:i];
        [pvc addQuestionWithText:[qr1 objectForKey:@"question"]];
        [pvc addAnswerWithText:[[qr1 objectForKey:@"reponses"] objectAtIndex:self.cid]];
        NSDictionary *qr2 = [confdata objectAtIndex:i+1];
        [pvc addQuestionWithText:[qr2 objectForKey:@"question"]];
        [pvc addAnswerWithText:[[qr2 objectForKey:@"reponses"] objectAtIndex:self.cid]];
        [self.confpages addObject:pvc];
        j++;
    }
    
    self.messpages = [[NSMutableArray alloc] init];
    int k = 0;
    for (int i = 0; i < [[messdata objectAtIndex:self.cid] count]; i++) {
        MessagesViewController *mvc = [[MessagesViewController alloc] init];
        mvc.pageindex = k;
        [mvc.view addSubview:mvc.mainLinearLayout];
        NSDictionary *m1 = [[messdata objectAtIndex:self.cid] objectAtIndex:i];
        [mvc addReferenceWithText:[m1 objectForKey:@"msg_ref"] cid:self.cid];
        [mvc addMessageWithText:[m1 objectForKey:@"msg"] cid:self.cid];
        [self.messpages addObject:mvc];
        k++;
    }
    
    self.confpvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.confpvc.view.frame = CGRectMake(0, 60, 309, 250);
    self.confpvc.dataSource = self;
    self.confpvc.delegate = self;
    
    [self.confpvc setViewControllers:@[[self.confpages objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.messpvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.messpvc.view.frame = CGRectMake(359, 60, 309, 250);
    self.messpvc.dataSource = self;
    self.messpvc.delegate = self;
    
    [self.messpvc setViewControllers:@[[self.messpages objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(334, 0, 1, 300)];
    sep2.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    [container addSubview:l];
    [container addSubview:l2];
    [container addSubview:sep];
    [container addSubview:sep3];
    [container addSubview:self.confpvc.view];
    [container addSubview:sep2];
    [container addSubview:self.messpvc.view];
    
    CSLinearLayoutItem *confitem = [CSLinearLayoutItem layoutItemForView:container];
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
    if (pageViewController == self.confpvc) {
        NSUInteger index = ((ConfessionsViewController*) viewController).pageindex;
        
        if (index == NSNotFound) {
            return nil;
        }
        
        index++;
        if (index == [self.confpages count]) {
            return nil;
        }
        if (([self.confpages count] == 0) || (index >= [self.confpages count])) {
            return nil;
        }
        
        return [self.confpages objectAtIndex:index];
    } else {
        NSUInteger index = ((MessagesViewController*) viewController).pageindex;
        
        if (index == NSNotFound) {
            return nil;
        }
        
        index++;
        if (index == [self.messpages count]) {
            return nil;
        }
        if (([self.messpages count] == 0) || (index >= [self.messpages count])) {
            return nil;
        }
        
        return [self.messpages objectAtIndex:index];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (pageViewController == self.confpvc) {
        NSUInteger index = ((ConfessionsViewController*) viewController).pageindex;
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil;
        }
        
        index--;
        if (([self.confpages count] == 0) || (index >= [self.confpages count])) {
            return nil;
        }
        
        return [self.confpages objectAtIndex:index];
    } else {
        NSUInteger index = ((MessagesViewController*) viewController).pageindex;
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil;
        }
        
        index--;
        if (([self.messpages count] == 0) || (index >= [self.messpages count])) {
            return nil;
        }
        
        return [self.messpages objectAtIndex:index];
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    if (pageViewController == self.confpvc) {
        return [self.confpages count];
    } else {
        return [self.messpages count];
    }
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
