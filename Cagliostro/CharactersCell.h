//
//  CharactersCell.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 12/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterCell.h"

@interface CharactersCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *charcv;
@end
