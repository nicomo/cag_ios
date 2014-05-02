//
//  ConfessionsViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 02/05/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "ConfessionsViewController.h"

@interface ConfessionsViewController ()

@end

@implementation ConfessionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithQuestion:(NSString *)question
{
    self = [super init];
    if (self) {
        [self addQuestionWithText:question];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // create the linear layout view
    self.mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    self.mainLinearLayout.backgroundColor = [UIColor clearColor];
    self.mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:self.mainLinearLayout];
}

- (void)addQuestionWithText:(NSString *)text
{
    UILabel *q = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 309, 25)];
    [q setText:text];
    [q setFont:[UIFont fontWithName:@"georgia" size:20]];
    q.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    q.userInteractionEnabled = NO;
    q.numberOfLines = 1;
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:q];
    [self.mainLinearLayout addItem:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
