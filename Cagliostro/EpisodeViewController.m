//
//  EpisodeViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "EpisodeViewController.h"
#import "CSLinearLayoutView.h"

@interface EpisodeViewController ()
- (void) addHeader:(int)partNumber title:(NSString*)titleText subtitle:(NSString*)subtitleText;
- (void) addParagraph:(NSString*)text;
- (void) addNextButton:(int)partNumber title:(NSString*)titleText;
@end

CSLinearLayoutView *mainLinearLayout;

@implementation EpisodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
    [self.view addSubview:mainLinearLayout];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"episode1" ofType:@"plist"];
    //NSArray *paragraphs = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];

    [self addHeader:1 title:[data objectForKey:@"title"] subtitle:[data objectForKey:@"subtitle"]];
    
    for (NSString *p in [data objectForKey:@"paragraphs"]) {
        [self addParagraph:p];
    }
    
    [self addNextButton:2 title:@"Des heures s’écoulèrent"];
}

- (void)addHeader:(int)partNumber title:(NSString *)titleText subtitle:(NSString *)subtitleText
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    header.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(85, 85*1.5, 768-85, 0)];
    title.text = [NSString stringWithFormat:@"%d. %@", partNumber, titleText];
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:50];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    [title sizeToFit];
    [header addSubview:title];
    
    UITextView *subtitle = [[UITextView alloc] initWithFrame:CGRectMake(85, 85*3.5, 768-85, 0)];
    subtitle.text = subtitleText;
    subtitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    subtitle.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.22 alpha:1.0];
    subtitle.backgroundColor = [UIColor clearColor];
    subtitle.userInteractionEnabled = NO;
    subtitle.scrollEnabled = NO;
    [subtitle sizeToFit];
    [header addSubview:subtitle];

    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:header];
    item.padding = CSLinearLayoutMakePadding(0, 0, 85, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;

    [mainLinearLayout addItem:item];
}

- (void)addParagraph:(NSString *)text
{
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 512, 0)];
    tv.text = text;
    tv.font = [UIFont fontWithName:@"Georgia" size:18];
    tv.textAlignment = NSTextAlignmentJustified;
    tv.userInteractionEnabled = NO;
    tv.scrollEnabled = NO;
    [tv sizeToFit];
    tv.backgroundColor = [UIColor clearColor];
    tv.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];

    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:tv];
    item.padding = CSLinearLayoutMakePadding(0, 85, 0, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;
    
    [mainLinearLayout addItem:item];
}

- (void)addNextButton:(int)partNumber title:(NSString *)titleText
{
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 768, 300)];
    nextButton.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];

    UITextView *nextPartLabel = [[UITextView alloc] initWithFrame:CGRectMake(85, 100, 768-85, 0)];
    nextPartLabel.text = [NSString stringWithFormat:@"Episode %d.", partNumber];
    nextPartLabel.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    nextPartLabel.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    nextPartLabel.backgroundColor = [UIColor clearColor];
    nextPartLabel.userInteractionEnabled = NO;
    nextPartLabel.scrollEnabled = NO;
    [nextPartLabel sizeToFit];
    [nextButton addSubview:nextPartLabel];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(85, 150, 768-85, 0)];
    title.text = titleText;
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    [title sizeToFit];
    [nextButton addSubview:title];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:nextButton];
    item.padding = CSLinearLayoutMakePadding(85, 0, 0, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;
    
    [mainLinearLayout addItem:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
