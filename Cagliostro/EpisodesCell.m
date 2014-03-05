//
//  EpisodesCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "EpisodesCell.h"
#import "EpisodesCollectionViewController.h"

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
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSize = CGSizeMake(115, 150);
        //layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //epcvc = [[EpisodesCollectionViewController alloc] initWithCollectionViewLayout:layout];
        epcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 768, 500) collectionViewLayout:layout];
        epcv.backgroundColor = [UIColor redColor];
        epcv.delegate = self;
        epcv.dataSource = self;
        //epcvc.collectionView.showsVerticalScrollIndicator = NO;
        [epcv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
        
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
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

@end
