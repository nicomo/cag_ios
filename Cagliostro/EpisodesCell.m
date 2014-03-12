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

        SixColumnsFlowLayout *layout = [[SixColumnsFlowLayout alloc] init];

        self.epcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 768, 1450) collectionViewLayout:layout];
        self.epcv.backgroundColor = [UIColor clearColor];
        self.epcv.delegate = self;
        self.epcv.dataSource = self;
        self.epcv.showsVerticalScrollIndicator = NO;
        self.epcv.scrollEnabled = NO;
        [self.epcv registerClass:[EpisodeCell class] forCellWithReuseIdentifier:@"EpisodeCell"];
        
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.epcv];
    }
    return self;
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
    int epid = indexPath.row;
    cell.title.text = [NSString stringWithFormat:@"%d. %@", epid+1, [data[epid] objectForKey:@"title"]];
    cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"homecard%d", epid+1]];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    CustomPageViewController *cpvc = [[CustomPageViewController alloc] initWithEpid:indexPath.row];
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [(UINavigationController *)ad.window.rootViewController pushViewController:cpvc animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)cv shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)cv shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

@end
