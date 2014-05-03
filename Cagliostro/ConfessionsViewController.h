//
//  ConfessionsViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 02/05/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLinearLayoutView.h"

@interface ConfessionsViewController : UIViewController
@property (nonatomic) int pageindex;
@property (strong, nonatomic) CSLinearLayoutView *mainLinearLayout;
- (void)addQuestionWithText:(NSString *)text;
- (void)addAnswerWithText:(NSString *)text;
@end
