//
//  CharacterViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 19/02/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) int cid;
- (id) initWithCid:(int) cid;
@property (strong, nonatomic) UICollectionView *charcv;
@end
