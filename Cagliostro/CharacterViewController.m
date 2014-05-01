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
    cell.title.text = [chardata[cid] objectForKey:@"name"];
    if ([self published:cid]) {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"character%d", cid]];
    } else {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"anon%@", [chardata[cid] objectForKey:@"gender"]]];
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

@end
