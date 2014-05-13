//
//  VideosCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 13/05/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "VideosCell.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation VideosCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        [button1 setImage:[UIImage imageNamed:@"bonus_1"] forState:UIControlStateNormal];
        button1.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        button1.layer.borderWidth = 1.0f;
        button1.tag = 1;
        [button1 addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *tv1 = [[UITextView alloc] initWithFrame:CGRectMake(149, 50, (768/2) - 174, 100)];
        tv1.backgroundColor = [UIColor whiteColor];
        tv1.userInteractionEnabled = NO;
        tv1.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique eu est eu cursus. Etiam sagittis ornare arcu at condimentum. Donec cursus nisi lacus, eget consequat velit elementum et.";
        tv1.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        tv1.layer.borderWidth = 1.0f;
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake((768/2) + 25, 50, 100, 100)];
        [button2 setImage:[UIImage imageNamed:@"bonus_2"] forState:UIControlStateNormal];
        button2.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        button2.layer.borderWidth = 1.0f;
        button2.tag = 2;
        [button2 addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *tv2 = [[UITextView alloc] initWithFrame:CGRectMake((768/2) + 124, 50, (768/2) - 174, 100)];
        tv2.backgroundColor = [UIColor whiteColor];
        tv2.userInteractionEnabled = NO;
        tv2.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique eu est eu cursus. Etiam sagittis ornare arcu at condimentum. Donec cursus nisi lacus, eget consequat velit elementum et.";
        tv2.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        tv2.layer.borderWidth = 1.0f;
        
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
        [button3 setImage:[UIImage imageNamed:@"bonus_3"] forState:UIControlStateNormal];
        button3.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        button3.layer.borderWidth = 1.0f;
        button3.tag = 3;
        [button3 addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *tv3 = [[UITextView alloc] initWithFrame:CGRectMake(149, 200, (768/2) - 174, 100)];
        tv3.backgroundColor = [UIColor whiteColor];
        tv3.userInteractionEnabled = NO;
        tv3.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique eu est eu cursus. Etiam sagittis ornare arcu at condimentum. Donec cursus nisi lacus, eget consequat velit elementum et.";
        tv3.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        tv3.layer.borderWidth = 1.0f;
        
        UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake((768/2) + 25, 200, 100, 100)];
        [button4 setImage:[UIImage imageNamed:@"bonus_4"] forState:UIControlStateNormal];
        button4.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        button4.layer.borderWidth = 1.0f;
        button4.tag = 4;
        [button4 addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *tv4 = [[UITextView alloc] initWithFrame:CGRectMake((768/2) + 124, 200, (768/2) - 174, 100)];
        tv4.backgroundColor = [UIColor whiteColor];
        tv4.userInteractionEnabled = NO;
        tv4.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique eu est eu cursus. Etiam sagittis ornare arcu at condimentum. Donec cursus nisi lacus, eget consequat velit elementum et.";
        tv4.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        tv4.layer.borderWidth = 1.0f;
        
        [self.contentView addSubview:button1];
        [self.contentView addSubview:button2];
        [self.contentView addSubview:button3];
        [self.contentView addSubview:button4];
        [self.contentView addSubview:tv1];
        [self.contentView addSubview:tv2];
        [self.contentView addSubview:tv3];
        [self.contentView addSubview:tv4];
    }
    return self;
}

- (void)playVideo:(UIButton *)sender
{
    int vid = sender.tag;
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"bonus_%d", vid] ofType:@"m4v" inDirectory:@"www"]];
    
    MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self.contentView.window.rootViewController presentMoviePlayerViewControllerAnimated:mpvc];
    
    mpvc.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [mpvc.moviePlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    NSLog(@"lala");
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
