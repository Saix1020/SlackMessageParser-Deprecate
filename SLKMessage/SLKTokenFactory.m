//
//  SLKTokenFactory.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKTokenFactory.h"
#import "SLKRegx.h"
#import "SLKToken.h"
#import "SLKBoldToken.h"
#import "SLKStrikeToken.h"
#import "SLKItalicsToken.h"
#import "SLKQuoteToken.h"
#import "SLKPreToken.h"
#import "SLKCodeToken.h"
#import "SLKLongQuoteToken.h"
#import "SLKTagToken.h"
#import "SLKUrlToken.h"
#import "SLKEmojiToken.h"
#import "SLKJumbomojiToken.h"

@implementation SLKTokenFactory

+(SLKToken*)createTokenWithString:(NSString*)string
               textCheckingResult:(NSTextCheckingResult*)match
                      attribuites:(NSDictionary*)attributes
                             regx:(SLKRegx *)regx
{
    SLKToken* token;
    
    switch (regx.type) {
        case kSLKBold:
        token = [[SLKBoldToken alloc] initWithString:string
                                  textCheckingResult:match
                                         attribuites:attributes
                                                regx:regx];
        break;
        
        case kSLKItalics:
        token = [[SLKItalicsToken alloc] initWithString:string
                                  textCheckingResult:match
                                         attribuites:attributes
                                                regx:regx];

        break;
        
        case kSLKStrike:
        token = [[SLKStrikeToken alloc] initWithString:string
                                  textCheckingResult:match
                                         attribuites:attributes
                                                regx:regx];

        break;
        
        case kSLKQuote:
        token = [[SLKQuoteToken alloc] initWithString:string
                                  textCheckingResult:match
                                         attribuites:attributes
                                                regx:regx];

        break;
            
        case kSLKLongQuote:
            token = [[SLKLongQuoteToken alloc] initWithString:string
                                       textCheckingResult:match
                                              attribuites:attributes
                                                     regx:regx];
            
            break;
        
        case kSLKCode:
        {
            
            token = [[SLKCodeToken alloc] initWithString:string
                                     textCheckingResult:match
                                            attribuites:attributes
                                                   regx:regx];

        }

        break;
        
        case kSLKPre:
        {
            
            token = [[SLKPreToken alloc] initWithString:string
                                      textCheckingResult:match
                                             attribuites:attributes
                                                    regx:regx];
            
        }
        
        break;
        case kSLKTag:
        {
            
            token = [[SLKTagToken alloc] initWithString:string
                                     textCheckingResult:match
                                            attribuites:attributes
                                                   regx:regx];
            
        }
            
            break;
            
        case kSLKUrl:
        {
            
            token = [[SLKUrlToken alloc] initWithString:string
                                     textCheckingResult:match
                                            attribuites:attributes
                                                   regx:regx];
            
        }
            
        break;
            
        case kSLKEmoji:
        {
            
            token = [[SLKEmojiToken alloc] initWithString:string
                                     textCheckingResult:match
                                            attribuites:attributes
                                                   regx:regx];
            
        }
            
        break;
            
        case kSLKJumbomoji:
        {
            
            token = [[SLKJumbomojiToken alloc] initWithString:string
                                     textCheckingResult:match
                                            attribuites:attributes
                                                   regx:regx];
            
        }
            
        break;
        
        default:
        token = [[SLKToken alloc] initWithString:string
                                  textCheckingResult:match
                                         attribuites:attributes
                                                regx:regx];

        break;
    }
    
    return token;
}


@end
