//
//  PlaceViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 30/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic) int plid;
- (id) initWithPlid:(int) plid;
@property (strong, nonatomic) UIView *map;
@property (strong, nonatomic) UIPageViewController *photopvc;
@property (strong, nonatomic) NSMutableArray *photopages;
@end
