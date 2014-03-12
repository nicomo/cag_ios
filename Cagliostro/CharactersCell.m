//
//  CharactersCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 12/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "CharactersCell.h"

@implementation CharactersCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 768, 100)];
        title.textAlignment = UITextAlignmentCenter;
        title.text = @"Les personnages";
        title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:40];
        title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(230, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        
        self.charcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, 768, 1450) collectionViewLayout:layout];
        self.charcv.backgroundColor = [UIColor clearColor];
        self.charcv.delegate = self;
        self.charcv.dataSource = self;
        self.charcv.showsVerticalScrollIndicator = NO;
        self.charcv.scrollEnabled = NO;
        [self.charcv registerClass:[CharacterCell class] forCellWithReuseIdentifier:@"CharacterCell"];
        
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:self.charcv];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CharacterCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CharacterCell" forIndexPath:indexPath];

    //cell.title.text = [NSString stringWithFormat:@"%d. %@", epid+1, [data[epid] objectForKey:@"title"]];
    //cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"homecard%d", epid+1]];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    /*CustomPageViewController *cpvc = [[CustomPageViewController alloc] initWithEpid:indexPath.row];
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [(UINavigationController *)ad.window.rootViewController pushViewController:cpvc animated:YES];*/
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
