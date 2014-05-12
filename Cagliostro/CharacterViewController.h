//
//  CharacterViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 19/02/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic) int cid;
- (id) initWithCid:(int) cid;
@property (strong, nonatomic) UICollectionView *charcv;
@property (strong, nonatomic) UIPageViewController *confpvc;
@property (strong, nonatomic) UIPageViewController *messpvc;
@property (strong, nonatomic) NSMutableArray *confpages;
@property (strong, nonatomic) NSMutableArray *messpages;
@end
