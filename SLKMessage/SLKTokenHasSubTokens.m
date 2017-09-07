//
//  SLKTokenHasSubTokens.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKTokenHasSubTokens.h"
#import "SLKRegx.h"
#import "SLKTokenParser.h"

@implementation SLKTokenHasSubTokens

-(NSArray<SLKRegx*>*)subTokenRegxs
{
    return @[
             [SLKRegx boldRegx],
             [SLKRegx italicsRegx],
             [SLKRegx strikeRegx],
             [SLKRegx codeRegx]
             ];
}

-(NSArray<SLKToken*>*)parseSubTokens
{
    NSArray* tokens = [SLKTokenParser parseWithString:self.matchedString attributes:self.attributes regxs:self.subTokenRegxs];
    
    return tokens;
}

-(NSArray*)_subTokensWithRegx:(SLKRegx*)regx
{
    NSRange range = NSMakeRange(0, self.matchedString.length);
    return [regx matchs:[self.matchedString substringWithRange:range]
             attributes:self.attributes];
    
}

-(NSMutableAttributedString*)encodeToAttributedString
{
    
    NSMutableAttributedString* finalString = [[NSMutableAttributedString alloc] init];
    for(SLKToken* token in self.subTokens){
        [finalString appendAttributedString:token.attributedString];
    }
    [finalString addAttribute:@"kSLKTokenType" value:@(self.regx.type) range:NSMakeRange(0, finalString.length)];
    return finalString;

}

-(NSString*)description
{
    NSMutableString* finalString = [[NSMutableString alloc] init];
    for(SLKToken* token in self.subTokens){
        [finalString appendString:[NSString stringWithFormat:@"%@", token.description]];
    }
    
    return finalString;


}

@end
