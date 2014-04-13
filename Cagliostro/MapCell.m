//
//  MapCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 11/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "MapCell.h"
#import "AppDelegate.h"
#import "PlaceViewController.h"

@implementation MapCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 768, 100)];
        title.textAlignment = UITextAlignmentCenter;
        title.text = @"Les lieux du roman";
        title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:40];
        title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];

        UIImageView* map = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 768, 548)];
        map.image = [UIImage imageNamed:@"map"];
        
        UIView* separator = [[UIView alloc] initWithFrame:CGRectMake(0, 667, 768, 1)];
        separator.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
        
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:map];
        [self.contentView addSubview:separator];
        
        int i = 0;
        for (NSMutableDictionary *place in pldata) {
            if ([self published:i]) {
                double x = [[place objectForKey:@"x"] doubleValue];
                double y = [[place objectForKey:@"y"] doubleValue];
                UIButton* placebtn = [[UIButton alloc] initWithFrame:CGRectMake((x*768) - 20, (y*548) - 20 + 120, 40, 40)];
                if (i < 7) {
                    [placebtn setBackgroundImage:[UIImage imageNamed:@"place_abbey"] forState:UIControlStateNormal];
                } else {
                    [placebtn setBackgroundImage:[UIImage imageNamed:@"place_other"] forState:UIControlStateNormal];
                }
                placebtn.tag = i;
                [placebtn addTarget:self action:@selector(didPressPlacePin:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:placebtn];
                [place setValue:@"YES" forKey:@"published"];
            }
            i++;
        }
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatePlaces:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)updatePlaces:(NSTimer *)timer
{
    int i = 0;
    for (NSMutableDictionary *place in pldata) {
        if ([self published:i] && ![[place objectForKey:@"published"] isEqual: @"YES"]) {
            double x = [[place objectForKey:@"x"] doubleValue];
            double y = [[place objectForKey:@"y"] doubleValue];
            UIButton* placebtn = [[UIButton alloc] initWithFrame:CGRectMake((x*768) - 20, (y*548) - 20 + 120, 40, 40)];
            if (i < 7) {
                [placebtn setBackgroundImage:[UIImage imageNamed:@"place_abbey"] forState:UIControlStateNormal];
            } else {
                [placebtn setBackgroundImage:[UIImage imageNamed:@"place_other"] forState:UIControlStateNormal];
            }
            placebtn.tag = i;
            [placebtn addTarget:self action:@selector(didPressPlacePin:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:placebtn];
            [place setValue:@"YES" forKey:@"published"];
        }
        i++;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
            bubble.frame = CGRectMake((x*768)+15, (y*548) -20 + 120, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblerightbottom"] forState:UIControlStateNormal];
            [self.contentView addSubview:bubble];
        }
        if (x > 0.5 && y < 0.5 ) {
            bubble.frame = CGRectMake((x*768)-15-250, (y*548) -20 + 120, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubbleleftbottom"] forState:UIControlStateNormal];
            [self.contentView addSubview:bubble];
        }
        if (x > 0.5 && y > 0.5 ) {
            bubble.frame = CGRectMake((x*768)-15-250, (y*548) -100 +20 + 120, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblelefttop"] forState:UIControlStateNormal];
            [self.contentView addSubview:bubble];
        }
        if (x < 0.5 && y > 0.5 ) {
            bubble.frame = CGRectMake((x*768)+15, (y*548) -100 +20 + 120, 250, 100);
            [bubble setBackgroundImage:[UIImage imageNamed:@"bubblerighttop"] forState:UIControlStateNormal];
            [self.contentView addSubview:bubble];
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

- (int)epidforplid:(int) plid
{
    return [[pldata[plid] objectForKey:@"epid"] intValue];
}

- (BOOL)published:(int) plid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool delayedEps = [prefs boolForKey:@"delayedEps"];
    double minElapsed = - [firstLaunchDate timeIntervalSinceNow] / 60.0f;
    return !delayedEps || [self epidforplid:plid] < minElapsed;
}

@end
