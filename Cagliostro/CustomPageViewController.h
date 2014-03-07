//
//  CustomPageViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 07/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeViewController.h"

@interface CustomPageViewController : UIViewController
- (void)nextPage:(int)epid;
- (void)previousPage:(int)epid;
@property (strong, nonatomic) EpisodeViewController *currentEpisodeController;
@end
