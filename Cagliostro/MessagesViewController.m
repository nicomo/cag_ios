//
//  ConfessionsViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 02/05/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "MessagesViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

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
    
    self.mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    self.mainLinearLayout.backgroundColor = [UIColor clearColor];
    self.mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
}

- (void)addMessageWithText:(NSString *)text cid:(int)cid
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 299, 50)];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"character%d", cid]]];
    avatar.frame = CGRectMake(0, 0, 50, 50);
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 299-70, 50)];
    [l setText:text];
    [l setFont:[UIFont fontWithName:@"georgia-italic" size:16]];
    l.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    l.userInteractionEnabled = NO;
    l.numberOfLines = 5;
    [l sizeToFit];
    
    UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 1, 50)];
    sep2.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    CGRect f = container.frame;
    if (l.frame.size.height > container.frame.size.height)
        f.size.height = l.frame.size.height;
    container.frame = f;
    
    [container addSubview:avatar];
    [container addSubview:sep2];
    [container addSubview:l];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:container];
    item.padding = CSLinearLayoutMakePadding(5, 5, 5, 5);
    [self.mainLinearLayout addItem:item];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 299, 1)];
    sep.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    
    CSLinearLayoutItem *sepitem = [CSLinearLayoutItem layoutItemForView:sep];
    sepitem.padding = CSLinearLayoutMakePadding(5, 5, 5, 5);
    [self.mainLinearLayout addItem:sepitem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
