//
//  ExpanderCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 11/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "ExpanderCell.h"

@implementation ExpanderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView* separator1 = [[UIView alloc] initWithFrame:CGRectMake(200, 20, 368, 1)];
        separator1.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, 768, 80)];
        self.title.textAlignment = UITextAlignmentCenter;
        self.title.font = [UIFont fontWithName:@"Georgia" size:20];
        self.title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        
        self.expandIcon = [[UIImageView alloc] initWithFrame:CGRectMake(334, 86, 100, 30)];
        self.expandIcon.image = [UIImage imageNamed:@"expanderDown"];
        
        UIView* separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, 134, 768, 1)];
        separator2.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
        
        [self.contentView addSubview:separator1];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.expandIcon];
        [self.contentView addSubview:separator2];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
