//
//  CharacterViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 19/02/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterViewController : UIViewController
@property (nonatomic) int cid;
- (id) initWithCid:(int) cid;
@end
