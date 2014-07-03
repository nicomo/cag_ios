//
//  EpisodesCell.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeCell.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface EpisodesCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) UICollectionView *epcv;
@property (strong, nonatomic) NSTimer *timer;
- (CGRect) sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
