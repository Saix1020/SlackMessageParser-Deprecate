//
//  SLKQuoteToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKQuoteToken.h"
#import "SLKRegx.h"

@implementation SLKQuoteToken

-(NSArray<SLKRegx*>*)subTokenRegxs
{
    return @[
             [SLKRegx boldRegx],
             [SLKRegx italicsRegx],
             [SLKRegx strikeRegx],
             [SLKRegx preRegx],
             [SLKRegx codeRegx],
             [SLKRegx tagRegx],
             [SLKRegx emojiRegx],
             ];
}


-(NSString*)matchedString
{
    NSRange matchedRang = [self.match rangeAtIndex:2];
    return [self.string substringWithRange:matchedRang];
}

-(NSString*)prefixString
{
    NSRange prefixRang = [self.match rangeAtIndex:1];
    NSString* preStr = [self.string substringWithRange:prefixRang];
    if([preStr hasPrefix:@"\n"]){
        preStr = [preStr substringFromIndex:1];
    }
    
    return preStr;
}



-(NSMutableAttributedString*)encodeToAttributedString
{
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"<quote>\n" attributes:self.attributes] atIndex:0];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n</quote>" attributes:self.attributes] atIndex:attrStr.length];
    
    return attrStr;
}


-(NSArray*)components
{
    SLKMessageContainerView* quoteMessageView = [SLKMessageContainerView new];
    quoteMessageView.marginLine.hidden = NO;
    quoteMessageView.messageView.textContainerInset = UIEdgeInsetsMake(4, -4, 4, 0);

    [quoteMessageView displayTokens:self.subTokens];
    return @[self.prefixAttrStr, quoteMessageView];
}



@end
