//
//  EpisodesCell.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodesCollectionViewController.h"

@interface EpisodesCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource> {
    UICollectionView* epcv;
}
@end
