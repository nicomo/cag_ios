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
        
        /*UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSize = CGSizeMake(115, 150);*/
        
        SixColumnsFlowLayout *layout = [[SixColumnsFlowLayout alloc] init];
        //layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //layout.itemSize = CGSizeMake(115, 150);

        epcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 768, 1450) collectionViewLayout:layout];
        epcv.backgroundColor = [UIColor clearColor];
        epcv.delegate = self;
        epcv.dataSource = self;
        epcv.showsVerticalScrollIndicator = NO;
        epcv.scrollEnabled = NO;
        [epcv registerClass:[EpisodeCell class] forCellWithReuseIdentifier:@"EpisodeCell"];
        
        [self.contentView addSubview:epcv];
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
