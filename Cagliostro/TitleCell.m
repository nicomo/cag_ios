//
//  titleCell.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 04/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "TitleCell.h"

@implementation TitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel* journalTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 768, 100)];
        journalTitle.textAlignment = UITextAlignmentCenter;
        journalTitle.text = @"LE JOURNAL";
        journalTitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:60];
        journalTitle.textColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
        
        UIView* separator = [[UIView alloc] initWithFrame:CGRectMake(0, 130, 768, 1)];
        separator.backgroundColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
        
        UILabel* authorName = [[UILabel alloc] initWithFrame:CGRectMake(0, 131, 768, 100)];
        authorName.textAlignment = UITextAlignmentCenter;
        authorName.text = @"Maurice Leblanc";
        authorName.font = [UIFont fontWithName:@"Georgia" size:30];
        authorName.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        
        UIImageView* imageSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(234, 221, 300, 20)];
        imageSeparator.image = [UIImage imageNamed:@"imageSeparator"];
        
        UILabel* bookTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 234, 768, 100)];
        bookTitle.textAlignment = UITextAlignmentCenter;
        bookTitle.text = @"La Comtesse de Cagliostro";
        bookTitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:40];
        bookTitle.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
        
        [self.contentView addSubview:journalTitle];
        [self.contentView addSubview:separator];
        [self.contentView addSubview:authorName];
        [self.contentView addSubview:imageSeparator];
        [self.contentView addSubview:bookTitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
