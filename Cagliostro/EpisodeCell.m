//
//  EpisodeCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "EpisodeCell.h"

@implementation EpisodeCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor yellowColor];
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        bottom.backgroundColor = [UIColor whiteColor];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width-10, 30)];
        self.title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:10];
        self.title.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
        self.title.userInteractionEnabled = NO;
        
        self.layer.borderColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0].CGColor;
        self.layer.borderWidth = 1;
        
        [bottom addSubview:self.title];
        [self.contentView addSubview:bottom];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end