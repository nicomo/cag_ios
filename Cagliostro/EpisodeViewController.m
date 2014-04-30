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
#import "PlaceViewController.h"
#import "UIView+Toast.h"

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
    
    [self addHeader:self.epid+1 title:[epdata[self.epid] objectForKey:@"title"] subtitle:[epdata[self.epid] objectForKey:@"subtitle"]];
    
    self.wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 768)];
    self.wv.backgroundColor = self.view.backgroundColor;
    self.wv.delegate = self;
    self.wv.opaque = NO;
    self.wv.scrollView.scrollEnabled = NO;
    self.wv.scrollView.bounces = NO;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", self.epid+1] ofType:@"html" inDirectory:@"www"]];
    [self.wv loadRequest:[NSURLRequest requestWithURL:url]];
    CSLinearLayoutItem *wvitem = [CSLinearLayoutItem layoutItemForView:self.wv];
    
    [mainLinearLayout addItem:wvitem];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 1)];
    [separator setBackgroundColor:[UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0]];
    CSLinearLayoutItem *sepitem = [CSLinearLayoutItem layoutItemForView:separator];
    sepitem.padding = CSLinearLayoutMakePadding(0, 85, 0, 85);
    [mainLinearLayout addItem:sepitem];
    
    UILabel *footertitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    footertitle.text = @"DANS CET EPISODE";
    footertitle.font = [UIFont fontWithName:@"Georgia" size:15];
    CSLinearLayoutItem *ftitem = [CSLinearLayoutItem layoutItemForView:footertitle];
    ftitem.padding = CSLinearLayoutMakePadding(0, 85, 0, 85);
    [mainLinearLayout addItem:ftitem];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 5);
    
    self.charcv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 768 - (85*2),
                                                                     (65 * (int)(([[epdata[self.epid] objectForKey:@"pins"] count]/8)+1))
                                                                     ) collectionViewLayout:layout];
    self.charcv.backgroundColor = [UIColor clearColor];
    self.charcv.delegate = self;
    self.charcv.dataSource = self;
    self.charcv.showsVerticalScrollIndicator = NO;
    self.charcv.scrollEnabled = NO;
    [self.charcv registerClass:[FooterCharacterCell class] forCellWithReuseIdentifier:@"FooterCharacterCell"];

    CSLinearLayoutItem *charsitem = [CSLinearLayoutItem layoutItemForView:self.charcv];
    charsitem.padding = CSLinearLayoutMakePadding(10, 85, 20, 85);
    [mainLinearLayout addItem:charsitem];
    
    self.map = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768 - (85*2), 428)];
    
    UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768 - (85*2), 428)];
    mapimg.image = [UIImage imageNamed:@"map"];
    [self.map addSubview:mapimg];
    
    CSLinearLayoutItem *mapitem = [CSLinearLayoutItem layoutItemForView:self.map];
    mapitem.padding = CSLinearLayoutMakePadding(0, 85, 40, 85);
    [mainLinearLayout addItem:mapitem];
    
    for (NSNumber *plid in [epdata[self.epid] objectForKey:@"places"]) {
        NSMutableDictionary *place = pldata[[plid intValue]];
        double x = [[place objectForKey:@"x"] doubleValue];
        double y = [[place objectForKey:@"y"] doubleValue];
        UIButton* placebtn = [[UIButton alloc] initWithFrame:CGRectMake((x*598) - 20, (y*428) - 20, 40, 40)];
        if ([plid intValue] < 7) {
            [placebtn setBackgroundImage:[UIImage imageNamed:@"place_abbey"] forState:UIControlStateNormal];
        } else {
            [placebtn setBackgroundImage:[UIImage imageNamed:@"place_other"] forState:UIControlStateNormal];
        }
        placebtn.tag = [plid intValue];
        [placebtn addTarget:self action:@selector(didPressPlacePin:) forControlEvents:UIControlEventTouchUpInside];
        [self.map addSubview:placebtn];
    }

    if (self.epid < 51)
        [self addNextButton:self.epid+2 title:[epdata[self.epid+1] objectForKey:@"title"]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FooterCharacterCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FooterCharacterCell" forIndexPath:indexPath];
    int cid = [[[epdata[self.epid] objectForKey:@"chars"] objectAtIndex:indexPath.row] intValue];
    if ([self charpublished:cid]) {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"character%d", cid]];
    } else {
        cell.thumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"anon%@", [chardata[cid] objectForKey:@"gender"]]];
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [[epdata[self.epid] objectForKey:@"chars"] count];
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    int cid = [[[epdata[self.epid] objectForKey:@"chars"] objectAtIndex:indexPath.row] intValue];
    if ([self charpublished:cid]) {
        CharacterViewController *cvc = [[CharacterViewController alloc] initWithCid:cid];
        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [(UINavigationController *)ad.window.rootViewController pushViewController:cvc animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)cv shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)cv shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

- (int)epidforcid:(int) cid
{
    return [[chardata[cid] objectForKey:@"epid"] intValue];
}

- (BOOL)charpublished:(int) cid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    return !delayedEps || [self epidforcid:cid] < minElapsed;
}

- (void)didPressPlacePin:(UIButton *)sender
{
    int plid = sender.tag;
    
    NSMutableDictionary *place = pldata[plid];
    double x = [[place objectForKey:@"x"] doubleValue];
    double y = [[place objectForKey:@"y"] doubleValue];
    NSString *name = [place objectForKey:@"name"];
    
    if (![place objectForKey:@"bubble"]) {
        
        [self clearBubbles];
        
        UIButton *bubble = [[UIButton alloc] init];
        bubble.tag = plid;
        [bubble addTarget:self action:@selector(didPressBubble:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *buttonTitle = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, 210, 90)];
        buttonTitle.text = name;
        buttonTitle.font = [UIFont fontWithName:@"Georgia" size:15];
        buttonTitle.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        buttonTitle.backgroundColor = [UIColor clearColor];
        buttonTitle.userInteractionEnabled = NO;
        buttonTitle.scrollEnabled = NO;
        [buttonTitle sizeToFit];
        [bubble addSubview:buttonTitle];
        
        if (x < 0.5 && y < 0.5 ) {
            bubble.frame = CGRectMake((x*598)+15, (y*428) -20, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblerightbottom"] forState:UIControlStateNormal];
            [self.map addSubview:bubble];
        }
        if (x > 0.5 && y < 0.5 ) {
            bubble.frame = CGRectMake((x*598)-15-250, (y*428) -20, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubbleleftbottom"] forState:UIControlStateNormal];
            [self.map addSubview:bubble];
        }
        if (x > 0.5 && y > 0.5 ) {
            bubble.frame = CGRectMake((x*598)-15-250, (y*428) -100 +20, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblelefttop"] forState:UIControlStateNormal];
            [self.map addSubview:bubble];
        }
        if (x < 0.5 && y > 0.5 ) {
            bubble.frame = CGRectMake((x*598)+15, (y*428) -100 +20, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblerighttop"] forState:UIControlStateNormal];
            [self.map addSubview:bubble];
        }
        
        [place setValue:bubble forKey:@"bubble"];
    } else {
        [[place objectForKey:@"bubble"] removeFromSuperview];
        [place setValue:nil forKey:@"bubble"];
    }
}

- (void)didPressBubble:(UIButton *)sender
{
    [self clearBubbles];
    int plid = sender.tag;
    PlaceViewController *pvc = [[PlaceViewController alloc] initWithPlid:plid];
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [(UINavigationController *)ad.window.rootViewController pushViewController:pvc animated:YES];
}

- (void)clearBubbles
{
    for (NSMutableDictionary *pl in pldata) {
        [[pl objectForKey:@"bubble"] removeFromSuperview];
        [pl setValue:nil forKey:@"bubble"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    self.parentViewController.navigationItem.title = [epdata[self.epid] objectForKey:@"title"];

    /*if (self.epid > 0)
    {
        [self.parentViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:[data[self.epid-1] objectForKey:@"title"] style:UIBarButtonItemStyleBordered target:self action:@selector(didPressPreviousButton:)]];
    }*/
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.player.view.alpha = 1 - (scrollView.contentOffset.y + 64) / self.player.view.frame.size.height;
    [self.player.view setFrame: CGRectMake(0, (scrollView.contentOffset.y + 64) / 3, 768, self.player.view.frame.size.height)];
    [self updatePins];
    
    float offset = scrollView.contentOffset.y / (scrollView.contentSize.height - 1024.0);
    
    int cid = 0;
    for (NSArray *charmessagelist in messdata) {
        for (NSMutableDictionary *message in charmessagelist) {
            if ([message objectForKey:@"toast"] && [[message objectForKey:@"epid"] intValue] == self.epid && offset >= [[message objectForKey:@"para"] floatValue] && ! [message objectForKey:@"shown"]) {
                [self.view makeToast:[message objectForKey:@"msg"]
                            duration:2.0
                            position:@"bottom"
                               title:[chardata[cid] objectForKey:@"name"]
                               image:[UIImage imageNamed:[NSString stringWithFormat:@"character%d", cid]]];
                [message setValue:@"YES" forKey:@"shown"];
            }
        }
        cid++;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.wv sizeToFit];
    [self placePins:webView];
    [self performSelector:@selector(updatePins) withObject:nil afterDelay:1.0];
    if (self.epid < 51)
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateButton:) userInfo:nil repeats:YES];
}

-(void)placePins:(UIWebView *)webView
{
    int lastp = 0;
    int offset = 0;
    for (NSMutableDictionary *pin in [epdata[self.epid] objectForKey:@"pins"]) {
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
    
    for (NSMutableDictionary *pin in [epdata[self.epid] objectForKey:@"pins"]) {
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
                                    [pinButton setTag:[[pin objectForKey:@"cid"] intValue]];
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
        self.nextButtonTitle.text = [epdata[self.epid + 1] objectForKey:@"title"];
        [self.nextButton addTarget:self action:@selector(didPressNextButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addHeader:(int)partNumber title:(NSString *)titleText subtitle:(NSString *)subtitleText
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 0)];
    header.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"header_%d", self.epid] ofType:@"m4v" inDirectory:@"www"]];
    
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

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.timer = nil;
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
    int cid = sender.tag;
    CharacterViewController *characterController = [[CharacterViewController alloc] initWithCid:cid];
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

- (int)epidforplid:(int) plid
{
    return [[pldata[plid] objectForKey:@"epid"] intValue];
}

- (BOOL)placepublished:(int) plid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    return !delayedEps || [self epidforplid:plid] < minElapsed;
}

@end
