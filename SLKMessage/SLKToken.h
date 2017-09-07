//
//  SLKToken.h
//  SLKMessage
//
//  Created by saix on 2017/8/23.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SLKMessageView.h"
#import "SLKMessageContainerView.h"

//@class SLKMessageView;

typedef enum : NSUInteger {
    kSLKText = 0,
    kSLKBold = 1,
    kSLKPre,
    kSLKItalics,
    kSLKStrike,
    kSLKCode,
    kSLKQuote,
    kSLKEmoji,
    kSLKJumbomoji,
    kSLKLongQuote,
    kSLKUrl,
    kSLKTag,
    kSLKOther,

} SLKTokenType;

@class SLKMessageContainerView;
@class SLKRegx;

@interface SLKToken : NSObject

@property (nonatomic, readonly) SLKRegx* regx;
@property (nonatomic, readonly) NSString* string;
@property (nonatomic, readonly) NSDictionary* attributes;
@property (nonatomic, readonly) NSAttributedString* attributedString;
@property (nonatomic, readonly) NSString* matchedString;
@property (nonatomic, readonly) NSArray<SLKToken*>* subTokens;
@property (nonatomic, readonly) NSTextCheckingResult* match;
@property (nonatomic, readonly) NSString* prefixString;
@property (nonatomic, readonly) NSString* suffixString;
@property (nonatomic, readonly) NSAttributedString* prefixAttrStr;
@property (nonatomic, readonly) NSAttributedString* suffixAttrStr;

@property (nonatomic, readonly) SLKMessageContainerView* containerView;
@property (nonatomic, readonly) NSArray* components;
@property (nonatomic, weak) SLKToken* prevToken;

//@property (nonatomic, strong) SLKMessageView* containerView;

-(instancetype)initWithString:(NSString*)string
           textCheckingResult:(NSTextCheckingResult*)match
                  attribuites:(NSDictionary*)attributes
                         regx:(SLKRegx *)regx;

-(instancetype)initWithString:(NSString*)string
           textCheckingResult:(NSTextCheckingResult*)match
                         regx:(SLKRegx *)regx;

+(NSDictionary*)defaultAttributes;
-(NSMutableAttributedString*)encodeToAttributedString;


@end
