//
//  SLKTokenParser.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKTokenParser.h"
#import "SLKToken.h"
#import "SLKRegx.h"
#import "SLKTokenFactory.h"

//+(SLKRegx*)boldRegx;
//+(SLKRegx*)italicsRegx;
//+(SLKRegx*)strikeRegx;
//+(SLKRegx*)codeRegx;
//+(SLKRegx*)preRegx;
//+(SLKRegx*)quoteRegx;
//+(SLKRegx*)emojiRegx;
//+(SLKRegx*)jumbomojiRegx;
//+(SLKRegx*)longQuoteRegx;
//+(SLKRegx*)urlRegx;
//+(SLKRegx*)tagRegx;

@implementation SLKTokenParser

//+(NSArray<SLKToken*>*)parseWithString:(NSString*)string attributes:(NSDictionary*)attributes regxs:(NSArray<SLKRegx*>*)regxs
//{
//    return [self parseWithString:string attributes:attributes regxs:regxs needAddRawText:YES];
//}

+(NSArray<SLKToken*>*)parseWithString:(NSString*)string attributes:(NSDictionary*)attributes regxs:(NSArray<SLKRegx*>*)regxs
{
    NSMutableArray* subTokens = [[NSMutableArray alloc] init];
    
    NSString* needMacthString = [string copy];
    NSUInteger cursor = 0;
    while(needMacthString.length>0){
        SLKToken* token;
        for(SLKRegx* regx in regxs){
            SLKToken* newToken = [regx matchsFirst:needMacthString attributes:attributes];
            if(!token) {
                token = newToken;
            }
            else if(newToken){
                if(token.match.range.location > newToken.match.range.location) {
                    token = newToken;
                }
                else if(token.match.range.location == newToken.match.range.location && token.match.range.length < newToken.match.range.length){
                    token = newToken;
                }
            }
        }
        
        if(!token){
            [subTokens addObject:[SLKTokenFactory createTokenWithString:[needMacthString substringFromIndex:cursor] textCheckingResult:nil attribuites:nil regx:nil]];

            needMacthString = nil;
            
        }
        
        else {
            
            if (token.match.range.location > cursor){
                [subTokens addObject:[[SLKToken alloc] initWithString:[needMacthString substringWithRange:NSMakeRange(cursor, token.match.range.location-cursor)] textCheckingResult:nil attribuites:attributes regx:nil]];
            }
            [subTokens addObject:token];
            
            
            needMacthString = [needMacthString substringFromIndex:token.match.range.location + token.match.range.length];
        }
    }
    SLKToken* prevToken = nil;
    for(SLKToken* t in subTokens) {
        t.prevToken = prevToken;
        prevToken = t;
    }
    
    
    return subTokens;

}

+(NSArray<SLKToken*>*)parseWithString:(NSString*)string attributes:(NSDictionary*)attributes
{
    NSArray* regxs = @[ [SLKRegx boldRegx],
                        [SLKRegx italicsRegx],
                        [SLKRegx strikeRegx],
                        [SLKRegx preRegx],          // make sure pre above code
                        [SLKRegx codeRegx],
                        [SLKRegx longQuoteRegx],    // make sure long quote above quote
                        [SLKRegx quoteRegx],
                        [SLKRegx jumbomojiRegx],    // make sure jumbomojiRegx above emojiRegx
                        [SLKRegx emojiRegx],
                        [SLKRegx urlRegx],
                        [SLKRegx tagRegx],
                        ];
    
    return [self parseWithString:string attributes:attributes regxs:regxs];
}

@end
