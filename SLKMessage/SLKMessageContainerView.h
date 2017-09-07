//
//  SLKMessageContainerView.h
//  SLKMessage
//
//  Created by saix on 2017/9/1.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLKToken;
@class SLKMessageView;

@interface SLKMessageContainerView : UIView
@property (nonatomic, readonly)SLKMessageView* messageView;
@property (nonatomic, readonly) UIView* marginLine;
@property (nonatomic, readonly) CGFloat height;

//@property (nonatomic, readonly) SLKMessageView*

-(void)displayTokens:(NSArray<SLKToken*>*)tokens;
-(void)displayTokens:(NSArray<SLKToken*>*)tokens inRect:(CGRect)rect;

@end
