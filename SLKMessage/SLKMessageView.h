//
//  SLKMessageView.h
//  SLKMessage
//
//  Created by saix on 2017/8/31.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLKToken;

#define kSLKURLProtocolTagLinkScheme @"SLKTag"


#define _RGBCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SLKMessageView : UITextView<UITextViewDelegate>

@property(nonatomic, strong) NSArray<SLKToken*>* tokens;
-(void)displaySubTokens:(NSArray*)tokens;
@end
