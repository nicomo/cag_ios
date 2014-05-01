//
//  CharacterCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 12/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "CharacterCell.h"

@implementation CharacterCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, frame.size.width-100, frame.size.height)];
        self.title.font = [UIFont fontWithName:@"Georgia" size:16];
        self.title.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
        self.title.userInteractionEnabled = NO;
        self.title.numberOfLines = 2;
        
        self.thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anonMale"]];
        self.thumb.frame = CGRectMake(0, 15, 70, 70);

        [self.contentView addSubview:self.thumb];
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
