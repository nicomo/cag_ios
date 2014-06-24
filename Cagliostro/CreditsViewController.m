//
//  CreditsViewController.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/06/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "CreditsViewController.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
        self.parentViewController.navigationItem.title = @"Crédits & mentions légales";
        UIWebView *wv = [[UIWebView alloc] initWithFrame:self.view.frame];
        wv.opaque = NO;
        wv.backgroundColor = self.view.backgroundColor;
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"credits" ofType:@"html" inDirectory:@"www"]];
        [wv loadRequest:[NSURLRequest requestWithURL:url]];
        [self.view addSubview:wv];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
