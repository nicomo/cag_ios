//
//  CreditsCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/06/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "CreditsCell.h"

@implementation CreditsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 768, 80)];
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont fontWithName:@"Georgia" size:20];
        title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        [title setText:@"Crédits & mentions légales"];
        
        [self.contentView addSubview:title];
    }
    return self;
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
