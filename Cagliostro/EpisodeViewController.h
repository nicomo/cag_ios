//
//  EpisodeViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface EpisodeViewController : UIViewController <UIWebViewDelegate, MPMediaPickerControllerDelegate, UIScrollViewDelegate>
- (id) initWithEpid:(int) epid;
@property (nonatomic) int epid;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UITextView *nextButtonTitle;
@property (strong, nonatomic) VideoPlayerViewController *player;
@property (strong, nonatomic) UIWebView *wv;
@property (strong, nonatomic) NSTimer *timer;
@end
