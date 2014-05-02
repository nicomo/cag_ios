//
//  AppDelegate.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSDate *firstLaunchDate;
NSDate *firstLaunchDate;

extern NSMutableArray *epdata;
NSMutableArray *epdata;

extern NSMutableArray *chardata;
NSMutableArray *chardata;

extern NSMutableArray *pldata;
NSMutableArray *pldata;

extern NSMutableArray *messdata;
NSMutableArray *messdata;

extern NSMutableArray *confdata;
NSMutableArray *confdata;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
