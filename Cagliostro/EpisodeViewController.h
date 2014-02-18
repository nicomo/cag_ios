//
//  EpisodeViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface EpisodeViewController : UIViewController <UIWebViewDelegate, MPMediaPickerControllerDelegate, UIScrollViewDelegate>
@property (nonatomic) int epid;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UITextView *nextButtonTitle;
@property (strong, nonatomic) MPMoviePlayerController *player;
@end
