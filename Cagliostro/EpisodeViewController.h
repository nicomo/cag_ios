//
//  EpisodeViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EpisodeViewController : UIViewController
@property (nonatomic) int epid;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UITextView *nextButtonTitle;
@end
