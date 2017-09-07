//
//  SLKLongQuoteToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKLongQuoteToken.h"
#import "SLKRegx.h"
#import "NSString+SLKMessage.h"

@interface SLKLongQuoteToken ()

@property (nonatomic, strong) NSString* prevGts;

@end


@implementation SLKLongQuoteToken
-(NSArray<SLKRegx*>*)subTokenRegxs
{
    return @[
             [SLKRegx boldRegx],
             [SLKRegx italicsRegx],
             [SLKRegx strikeRegx],
             [SLKRegx quoteRegx],
             [SLKRegx preRegx],
             [SLKRegx codeRegx],
             [SLKRegx tagRegx],
             [SLKRegx emojiRegx],
             ];
}

-(NSString*)matchedString
{
    NSString* matchedString = [super matchedString];
    
//    if(matchedString.length==0){
//        return matchedString;
//    }
//    
    NSRange range = [matchedString rangeOfString:self.prevGts];
    if(range.location == NSNotFound) {
        return matchedString;
    }
    matchedString = [matchedString substringFromIndex:range.location+range.length];
    
//    NSRegularExpression* gtsRegx = [NSRegularExpression regularExpressionWithPattern:@"^(\\s*&gt;)+"
//                                                                                options:0
//                                                                                  error:nil];
//    
//    NSTextCheckingResult *match = [gtsRegx firstMatchInString:matchedString
//                                                        options:0
//                                                          range:NSMakeRange(0, matchedString.length)];
//    
//    if(match){
//        _prevGts = [matchedString substringWithRange:match.range];
//        matchedString = [matchedString substringFromIndex:match.range.location+match.range.length];
//    }

    
    
    return matchedString;
}

-(NSString*)prevGts
{
    if(!_prevGts){
        NSString* matchedString = [super matchedString];

        NSRegularExpression* gtsRegx = [NSRegularExpression regularExpressionWithPattern:@"^(\\s*&gt;)+"
                                                                                 options:0
                                                                                   error:nil];
        
        NSTextCheckingResult *match = [gtsRegx firstMatchInString:matchedString
                                                          options:0
                                                            range:NSMakeRange(0, matchedString.length)];
        if(match){
            _prevGts = [matchedString substringWithRange:match.range];
        }
        else {
            _prevGts = @"";
        }
    }
    return _prevGts;
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
    
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:[self.prevGts decodeGTLTAND] attributes:self.attributes] atIndex:0];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"<longquote>" attributes:self.attributes] atIndex:0];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"</longquote>" attributes:self.attributes] atIndex:attrStr.length];
    
    return attrStr;
}

-(NSArray*)components
{
    SLKMessageContainerView* quoteMessageView = [SLKMessageContainerView new];
    quoteMessageView.marginLine.hidden = NO;
    quoteMessageView.messageView.attributedText = [[NSAttributedString alloc] initWithString:[self.prevGts decodeGTLTAND] attributes:self.attributes];
    quoteMessageView.messageView.textContainerInset = UIEdgeInsetsMake(4, -4, 4, 0);

    [quoteMessageView displayTokens:self.subTokens];
    return @[self.prefixAttrStr, quoteMessageView];
}

@end
