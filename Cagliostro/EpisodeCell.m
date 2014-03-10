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
    NSLog(@"ini");
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor yellowColor];
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
