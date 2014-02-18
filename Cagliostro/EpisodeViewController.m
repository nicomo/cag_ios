//
//  EpisodeViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "EpisodeViewController.h"
#import "CSLinearLayoutView.h"

@interface EpisodeViewController ()
- (void) addHeader:(int)partNumber title:(NSString*)titleText subtitle:(NSString*)subtitleText;
- (void) addNextButton:(int)partNumber title:(NSString*)titleText;
- (void) updatePins;
@end

CSLinearLayoutView *mainLinearLayout;

@implementation EpisodeViewController

- (id)init
{
    self = [super init];
    self.epid = 0;
    return self;
}

- (id)initWithEpid:(int) epid
{
    self = [super init];
    self.epid = epid;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    // create the linear layout view
    mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    mainLinearLayout.backgroundColor = [UIColor clearColor];
    mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    mainLinearLayout.delegate = self;
    [self.view addSubview:mainLinearLayout];

    [self addHeader:self.epid+1 title:[data[self.epid] objectForKey:@"title"] subtitle:[data[self.epid] objectForKey:@"subtitle"]];
    
    self.navigationItem.title = [data[self.epid] objectForKey:@"title"];

    UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 768)];
    wv.backgroundColor = self.view.backgroundColor;
    wv.delegate = self;
    wv.opaque = NO;
    wv.scrollView.scrollEnabled = NO;
    wv.scrollView.bounces = NO;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", self.epid+1] ofType:@"html" inDirectory:@"www"]];
    [wv loadRequest:[NSURLRequest requestWithURL:url]];
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:wv];
    [mainLinearLayout addItem:item];

    [self addNextButton:self.epid+1 title:[data[self.epid+1] objectForKey:@"title"]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.player.view.alpha = 1 - (scrollView.contentOffset.y + 64) / self.player.view.frame.size.height;
    [self.player.view setFrame: CGRectMake(0, (scrollView.contentOffset.y + 64) / 3, 768, self.player.view.frame.size.height)];
    self.updatePins;
}

-(void)updatePins
{
    CGRect visibleRect;
    visibleRect.size = mainLinearLayout.bounds.size;
    visibleRect.origin = mainLinearLayout.contentOffset;
    
    for (NSMutableDictionary *pin in [data[self.epid] objectForKey:@"pins"]) {
        UIImageView *anon = [pin objectForKey:@"imageView"];
        
        if (CGRectContainsRect(visibleRect, anon.frame) && ![[pin objectForKey:@"state"] isEqual: @"flipped"] ) {
            [pin setValue:@"flipped" forKey:@"state"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                [UIView transitionWithView:anon
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionFlipFromRight
                                animations:^{
                                    NSString *anonImageName = [NSString stringWithFormat:@"character%d", 1];
                                    anon.image = [UIImage imageNamed:anonImageName];
                                } completion:^(BOOL finished) {}];
            });
            

            
        }
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView sizeToFit];
    
    for (NSMutableDictionary *pin in [data[self.epid] objectForKey:@"pins"]) {
        NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('p')[%d].getBoundingClientRect().top", [[pin objectForKey:@"pid"] intValue] - 1];
        NSString *jsresult = [webView stringByEvaluatingJavaScriptFromString:js];
        NSString *anonImageName = [NSString stringWithFormat:@"anon%@", [pin objectForKey:@"gender"]];
        UIImageView *anon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:anonImageName]];
        anon.frame = CGRectMake(768 - 130, [jsresult intValue] + webView.frame.origin.y, 70, 70);
        [mainLinearLayout addSubview:anon];
        [pin setObject:anon forKey:@"imageView"];
        [pin setObject:@"anon" forKey:@"state"];
    }

    [self performSelector:@selector(updatePins) withObject:nil afterDelay:1.0];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateButton:) userInfo:nil repeats:YES];
}

-(void)updateButton:(NSTimer *)timer {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];

    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    if (self.epid > minElapsed && delayedEps) {
        self.nextButtonTitle.text = [NSString stringWithFormat:@"A paraitre dans %5.2f minutes", self.epid - minElapsed];
        [self.nextButtonTitle sizeToFit];
    } else {
        self.nextButtonTitle.text = [data[self.epid + 1] objectForKey:@"title"];
        [self.nextButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addHeader:(int)partNumber title:(NSString *)titleText subtitle:(NSString *)subtitleText
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 0)];
    header.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"mp4" inDirectory:@"www"]];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL: url];
    [self.player prepareToPlay];
    self.player.controlStyle = MPMovieControlStyleNone;
    self.player.scalingMode=MPMovieScalingModeFill;
    [header addSubview: self.player.view];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 768, 0)];
    title.text = [NSString stringWithFormat:@"%d. %@", partNumber, titleText];
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:50];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    title.textContainerInset = UIEdgeInsetsMake(85*2, 85, 0, 0);
    [title sizeToFit];
    [header addSubview:title];
    
    UITextView *subtitle = [[UITextView alloc] initWithFrame:CGRectMake(0, title.frame.size.height, 768, 0)];
    subtitle.text = subtitleText;
    subtitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    subtitle.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.22 alpha:1.0];
    subtitle.backgroundColor = [UIColor clearColor];
    subtitle.userInteractionEnabled = NO;
    subtitle.scrollEnabled = NO;
    subtitle.textContainerInset = UIEdgeInsetsMake(85/2, 85, 85/2, 0);
    [subtitle sizeToFit];
    [header addSubview:subtitle];
    
    header.frame = CGRectMake(0, 0, 768, title.frame.size.height + subtitle.frame.size.height);
    [self.player.view setFrame: CGRectMake(0, 0, 768, title.frame.size.height + subtitle.frame.size.height + 100)];
    [self.player play];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:header];
    [mainLinearLayout addItem:item];
}

- (void)addNextButton:(int)partNumber title:(NSString *)titleText
{
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 768, 300)];
    self.nextButton.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];

    UITextView *nextPartLabel = [[UITextView alloc] initWithFrame:CGRectMake(85, 100, 768-85, 0)];
    nextPartLabel.text = [NSString stringWithFormat:@"Episode %d.", partNumber];
    nextPartLabel.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    nextPartLabel.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    nextPartLabel.backgroundColor = [UIColor clearColor];
    nextPartLabel.userInteractionEnabled = NO;
    nextPartLabel.scrollEnabled = NO;
    [nextPartLabel sizeToFit];
    [self.nextButton addSubview:nextPartLabel];
    
    self.nextButtonTitle = [[UITextView alloc] initWithFrame:CGRectMake(85, 150, 768-85, 0)];
    self.nextButtonTitle.text = titleText;
    self.nextButtonTitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    self.nextButtonTitle.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    self.nextButtonTitle.backgroundColor = [UIColor clearColor];
    self.nextButtonTitle.userInteractionEnabled = NO;
    self.nextButtonTitle.scrollEnabled = NO;
    [self.nextButtonTitle sizeToFit];
    [self.nextButton addSubview:self.nextButtonTitle];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:self.nextButton];
    [mainLinearLayout addItem:item];
}

- (void)didPressButton:(UIButton *)sender
{
    EpisodeViewController *nextEpisodeController = [[EpisodeViewController alloc] initWithEpid:self.epid+1];
    [self.navigationController pushViewController:nextEpisodeController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
