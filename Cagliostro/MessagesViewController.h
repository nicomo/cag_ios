//
//  MessagesViewController.h
//  Cagliostro
//
//  Created by Jean-André Santoni on 12/05/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLinearLayoutView.h"

@interface MessagesViewController : UIViewController
@property (nonatomic) int pageindex;
@property (strong, nonatomic) CSLinearLayoutView *mainLinearLayout;
- (void)addReferenceWithText:(NSString *)text cid:(int) cid;
- (void)addMessageWithText:(NSString *)text cid:(int) cid;
@end
