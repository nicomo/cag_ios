//
//  CustomPageViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 07/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "CustomPageViewController.h"


@interface CustomPageViewController ()

@end

@implementation CustomPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.currentEpisodeController = [[EpisodeViewController alloc] init];
    [self addChildViewController:self.currentEpisodeController];
    [self.view addSubview:self.currentEpisodeController.view];
    [self.currentEpisodeController didMoveToParentViewController:self];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)nextPage:(int)epid
{
    EpisodeViewController *nextEpisodeController = [[EpisodeViewController alloc] initWithEpid:epid];
    [self addChildViewController:nextEpisodeController];
    [self.view addSubview:nextEpisodeController.view];
    [nextEpisodeController didMoveToParentViewController:self];
    
    CGRect frame = nextEpisodeController.view.frame;
    frame.origin.x = 768;
    nextEpisodeController.view.frame = frame;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect frame = nextEpisodeController.view.frame;
                         frame.origin.x = 0;
                         nextEpisodeController.view.frame = frame;
                         
                         CGRect frame2 = self.currentEpisodeController.view.frame;
                         frame2.origin.x = -768/2;
                         self.currentEpisodeController.view.frame = frame2;
                         
                         self.currentEpisodeController.view.alpha = 0.75;
                     }
                     completion:^(BOOL finished){
                         [self.currentEpisodeController willMoveToParentViewController:nil];
                         [self.currentEpisodeController.view removeFromSuperview];
                         [self.currentEpisodeController removeFromParentViewController];
                         self.currentEpisodeController = nextEpisodeController;
                     }];
}

- (void)previousPage:(int)epid
{
    EpisodeViewController *nextEpisodeController = [[EpisodeViewController alloc] initWithEpid:epid];
    [self addChildViewController:nextEpisodeController];
    [self.view addSubview:nextEpisodeController.view];
    [nextEpisodeController didMoveToParentViewController:self];
    
    CGRect frame = nextEpisodeController.view.frame;
    frame.origin.x = -768;
    nextEpisodeController.view.frame = frame;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect frame = nextEpisodeController.view.frame;
                         frame.origin.x = 0;
                         nextEpisodeController.view.frame = frame;
                         
                         CGRect frame2 = self.currentEpisodeController.view.frame;
                         frame2.origin.x = 768/2;
                         self.currentEpisodeController.view.frame = frame2;
                         
                         self.currentEpisodeController.view.alpha = 0.75;
                     }
                     completion:^(BOOL finished){
                         [self.currentEpisodeController willMoveToParentViewController:nil];
                         [self.currentEpisodeController.view removeFromSuperview];
                         [self.currentEpisodeController removeFromParentViewController];
                         self.currentEpisodeController = nextEpisodeController;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
