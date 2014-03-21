//
//  EpisodesCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "EpisodesCell.h"
#import "CustomPageViewController.h"

@implementation EpisodesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.columnCount = 6;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        self.epcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 768, 1450) collectionViewLayout:layout];
        self.epcv.backgroundColor = [UIColor clearColor];
        self.epcv.delegate = self;
        self.epcv.dataSource = self;
        self.epcv.showsVerticalScrollIndicator = NO;
        self.epcv.scrollEnabled = NO;
        [self.epcv registerClass:[EpisodeCell class] forCellWithReuseIdentifier:@"EpisodeCell"];
        
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.epcv];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateEpisodes:) userInfo:nil repeats:YES];
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row / 6;
    NSInteger col = indexPath.row % 6;
    
    NSInteger det = row % 3;
    
    NSInteger INSET = 10;
    NSInteger WIDTH = 115;
    
    NSInteger LOW = 130;
    NSInteger HIGH = 190;
    
    if (       (col == 0 || col == 3) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, HIGH).size;
    } else if ((col == 0 || col == 3) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 40, WIDTH, LOW ).size;
    } else if ((col == 0 || col == 3) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 20, WIDTH, LOW ).size;
    }
    
    if (       (col == 1 || col == 4) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, LOW ).size;
    } else if ((col == 1 || col == 4) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 20, WIDTH, HIGH).size;
    } else if ((col == 1 || col == 4) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 20, WIDTH, LOW ).size;
    }
    
    if (       (col == 2 || col == 5) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, LOW ).size;
    } else if ((col == 2 || col == 5) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 20, WIDTH, LOW ).size;
    } else if ((col == 2 || col == 5) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 40, WIDTH, HIGH).size;
    }
    
    return CGRectMake(10 + col*125, 10 + row*160, 115, LOW).size;
}

-(void)updateEpisodes:(NSTimer *)timer
{
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    if (minElapsed > 1 && minElapsed < 51) {
        [self.epcv reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:(int)minElapsed inSection:0]]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 52;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EpisodeCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"EpisodeCell" forIndexPath:indexPath];
    int epid = (int)indexPath.row;
    cell.title.text = [NSString stringWithFormat:@"%d. %@", epid+1, [epdata[epid] objectForKey:@"title"]];
    
    if ([self published:epid]) {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"homecard%d", epid+1]];
    } else {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"disabled_homecard%d", epid+1]];
    }

    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if ([self published:indexPath.row]) {
        CustomPageViewController *cpvc = [[CustomPageViewController alloc] initWithEpid:(int)indexPath.row];
        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [(UINavigationController *)ad.window.rootViewController pushViewController:cpvc animated:YES];
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

- (BOOL)published:(int) epid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    return !delayedEps || epid < minElapsed;
}

@end
