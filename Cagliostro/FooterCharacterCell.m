//
//  FooterCharacterCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 16/04/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "FooterCharacterCell.h"

@implementation FooterCharacterCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anonMale"]];
        self.thumb.frame = CGRectMake(0, 0, 60, 60);
        
        [self.contentView addSubview:self.thumb];
    }
    return self;
}

@end
