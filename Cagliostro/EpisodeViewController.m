//
//  EpisodeViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "EpisodeViewController.h"
#import "CharacterViewController.h"
#import "CSLinearLayoutView.h"
#import "CustomPageViewController.h"

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
    
    if (self.epid >= 51)
        return;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    // create the linear layout view
    mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    mainLinearLayout.backgroundColor = [UIColor clearColor];
    mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    mainLinearLayout.delegate = self;
    [self.view addSubview:mainLinearLayout];
    
    [self addHeader:self.epid+1 title:[data[self.epid] objectForKey:@"title"] subtitle:[data[self.epid] objectForKey:@"subtitle"]];
    
    self.wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 768)];
    self.wv.backgroundColor = self.view.backgroundColor;
    self.wv.delegate = self;
    self.wv.opaque = NO;
    self.wv.scrollView.scrollEnabled = NO;
    self.wv.scrollView.bounces = NO;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", self.epid+1] ofType:@"html" inDirectory:@"www"]];
    [self.wv loadRequest:[NSURLRequest requestWithURL:url]];
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:self.wv];
    [mainLinearLayout addItem:item];

    [self addNextButton:self.epid+2 title:[data[self.epid+1] objectForKey:@"title"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.parentViewController.navigationItem.title = [data[self.epid] objectForKey:@"title"];

    if (self.epid > 0)
    {
        [self.parentViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:[data[self.epid-1] objectForKey:@"title"] style:UIBarButtonItemStyleBordered target:self action:@selector(didPressPreviousButton:)]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.player.view.alpha = 1 - (scrollView.contentOffset.y + 64) / self.player.view.frame.size.height;
    [self.player.view setFrame: CGRectMake(0, (scrollView.contentOffset.y + 64) / 3, 768, self.player.view.frame.size.height)];
    [self updatePins];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.wv sizeToFit];
    [self placePins:webView];
    [self performSelector:@selector(updatePins) withObject:nil afterDelay:1.0];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateButton:) userInfo:nil repeats:YES];
}

-(void)placePins:(UIWebView *)webView
{
    int lastp = 0;
    int offset = 0;
    for (NSMutableDictionary *pin in [data[self.epid] objectForKey:@"pins"]) {
        int pid = [[pin objectForKey:@"pid"] intValue];
        offset = (pid == lastp) ? offset + 80 : 0;
        NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('p')[%d].getBoundingClientRect().top", pid - 1];
        NSString *jsresult = [webView stringByEvaluatingJavaScriptFromString:js];
        NSString *pinImageName = [NSString stringWithFormat:@"anon%@", [pin objectForKey:@"gender"]];
        UIImage * pinImage = [UIImage imageNamed:pinImageName];
        UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pinButton.frame = CGRectMake(768 - 130, [jsresult intValue] + webView.frame.origin.y + offset, 70, 70);
        [pinButton setBackgroundImage:pinImage forState:UIControlStateNormal];
        [mainLinearLayout addSubview:pinButton ];
        [pin setObject:pinButton forKey:@"pinButton"];
        [pin setObject:@"anon" forKey:@"state"];
        lastp = pid;
    }
}

-(void)updatePins
{
    CGRect visibleRect;
    visibleRect.size = mainLinearLayout.bounds.size;
    visibleRect.origin = mainLinearLayout.contentOffset;
    
    for (NSMutableDictionary *pin in [data[self.epid] objectForKey:@"pins"]) {
        UIButton *pinButton = [pin objectForKey:@"pinButton"];
        
        if (CGRectContainsRect(visibleRect, pinButton.frame) && ![[pin objectForKey:@"state"] isEqual: @"flipped"] ) {
            [pin setValue:@"flipped" forKey:@"state"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                [UIView transitionWithView:pinButton
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionFlipFromRight
                                animations:^{
                                    NSString *anonImageName = [NSString stringWithFormat:@"character%d", [[pin objectForKey:@"cid"] intValue]];
                                    UIImage *pinImage = [UIImage imageNamed:anonImageName];
                                    [pinButton setBackgroundImage:pinImage forState:UIControlStateNormal];
                                    [pinButton addTarget:self action:@selector(didPressPinButton:) forControlEvents:UIControlEventTouchUpInside];
                                } completion:^(BOOL finished) {}];
            });
        }
    }
}

-(void)updateButton:(NSTimer *)timer
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];

    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    if (self.epid+1 > minElapsed && delayedEps) {
        self.nextButtonTitle.text = [NSString stringWithFormat:@"A paraitre dans %5.2f minutes", self.epid+1 - minElapsed];
        [self.nextButtonTitle sizeToFit];
    } else {
        self.nextButtonTitle.text = [data[self.epid + 1] objectForKey:@"title"];
        [self.nextButton addTarget:self action:@selector(didPressNextButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addHeader:(int)partNumber title:(NSString *)titleText subtitle:(NSString *)subtitleText
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 0)];
    header.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"mp4" inDirectory:@"www"]];
    
    self.player = [[VideoPlayerViewController alloc] init];
    self.player.URL = url;
    [header addSubview: self.player.view];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 768, 0)];
    title.text = [NSString stringWithFormat:@"%d. %@", partNumber, titleText];
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:50];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    title.textContainerInset = UIEdgeInsetsMake(85*2+64, 85, 0, 0);
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
    [self.player.view setFrame: CGRectMake(0, 0, 768, title.frame.size.height + subtitle.frame.size.height)];
    
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

- (void)didPressNextButton:(UIButton *)sender
{
    [self.timer invalidate];
    self.timer = nil;

    CustomPageViewController* cpvp = (CustomPageViewController *)self.parentViewController;
    [cpvp nextPage:self.epid+1];
}

- (void)didPressPreviousButton:(UIButton *)sender
{
    [self.timer invalidate];
    self.timer = nil;

    CustomPageViewController* cpvp = (CustomPageViewController *)self.parentViewController;
    [cpvp previousPage:self.epid-1];
}

- (void)didPressPinButton:(UIButton *)sender
{
    CharacterViewController *characterController = [[CharacterViewController alloc] initWithCid:0];
    [self.navigationController pushViewController:characterController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc %d", self.epid);
}

@end
