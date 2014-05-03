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
    
    self.mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    self.mainLinearLayout.backgroundColor = [UIColor clearColor];
    self.mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
}

- (void)addQuestionWithText:(NSString *)text
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 299, 50)];
    [l setText:text];
    [l setFont:[UIFont fontWithName:@"georgia-bold" size:16]];
    l.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    l.userInteractionEnabled = NO;
    l.numberOfLines = 2;
    [l sizeToFit];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:l];
    item.padding = CSLinearLayoutMakePadding(5, 5, 5, 5);
    [self.mainLinearLayout addItem:item];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 299, 1)];
    sep.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    CSLinearLayoutItem *sepitem = [CSLinearLayoutItem layoutItemForView:sep];
    sepitem.padding = CSLinearLayoutMakePadding(5, 5, 5, 5);
    [self.mainLinearLayout addItem:sepitem];
}

- (void)addAnswerWithText:(NSString *)text
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 299, 25)];
    [l setText:text];
    [l setFont:[UIFont fontWithName:@"georgia-italic" size:16]];
    l.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    l.userInteractionEnabled = NO;
    l.numberOfLines = 4;
    [l sizeToFit];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:l];
    item.padding = CSLinearLayoutMakePadding(5, 5, 5, 5);
    [self.mainLinearLayout addItem:item];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 299, 1)];
    sep.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    CSLinearLayoutItem *sepitem = [CSLinearLayoutItem layoutItemForView:sep];
    sepitem.padding = CSLinearLayoutMakePadding(5, 5, 10, 5);
    [self.mainLinearLayout addItem:sepitem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
