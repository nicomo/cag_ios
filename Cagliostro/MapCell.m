//
//  MapCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 11/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "MapCell.h"

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

        UIImageView* map = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 768, 768*(2100.0f/2580.0f))];
        map.image = [UIImage imageNamed:@"map"];
        
        UIView* separator = [[UIView alloc] initWithFrame:CGRectMake(0, 619, 768, 1)];
        separator.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
        
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:map];
        [self.contentView addSubview:separator];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
