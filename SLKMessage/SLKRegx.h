//
//  SLKReg.h
//  SLKMessage
//
//  Created by saix on 2017/8/23.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLKToken.h"

extern const NSString* kSLKBoldRegx;
extern const NSString* kSLKItalicsRegx;
extern const NSString* kSLKStrikeRegx;
extern const NSString* kSLKCodeRegx;
extern const NSString* kSLKPreRegx;
extern const NSString* kSLKQuoteRegx;
extern const NSString* kSLKEmojiRegx;
extern const NSString* kSLKJumbomojiRegx;
extern const NSString* kSLKLongQuoteRegx;
extern const NSString* kSLKUrlRegx;
extern const NSString* kSLKTagRegx;

@class SLKToken;

@interface SLKRegx : NSObject

@property (nonatomic, readonly) NSRegularExpression* regx;
@property (nonatomic, readonly) SLKTokenType type;

-(instancetype)initWithRegxStr:(NSString*)regxStr;
-(BOOL)matched:(NSString*)string;
-(NSArray<SLKToken*>*)matchs:(NSString*)string;
-(NSArray<SLKToken*>*)matchs:(NSString*)string attributes:(NSDictionary*)attrs;
-(SLKToken*)matchsFirst:(NSString*)string;
-(SLKToken*)matchsFirst:(NSString*)string attributes:(NSDictionary*)attrs;;

+(SLKRegx*)boldRegx;
+(SLKRegx*)italicsRegx;
+(SLKRegx*)strikeRegx;
+(SLKRegx*)codeRegx;
+(SLKRegx*)preRegx;
+(SLKRegx*)quoteRegx;
+(SLKRegx*)emojiRegx;
+(SLKRegx*)jumbomojiRegx;
+(SLKRegx*)longQuoteRegx;
+(SLKRegx*)urlRegx;
+(SLKRegx*)tagRegx;


@end
