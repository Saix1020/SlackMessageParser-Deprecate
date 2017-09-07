//
//  SLKTokenParser.h
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLKToken;
@class SLKRegx;

@interface SLKTokenParser : NSObject


+(NSArray<SLKToken*>*)parseWithString:(NSString*)string
                           attributes:(NSDictionary*)attributes;

+(NSArray<SLKToken*>*)parseWithString:(NSString*)string
                           attributes:(NSDictionary*)attributes
                                regxs:(NSArray<SLKRegx*>*)regxs;

//+(NSMutableArray<SLKToken*>*)traversalTokens:(NSMutableArray<SLKToken*>*)tokens;

@end
