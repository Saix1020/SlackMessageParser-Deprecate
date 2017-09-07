//
//  SLKPreToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKPreToken.h"

@implementation SLKPreToken
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
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"^$"
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:nil];
    
    NSArray *matches = [regx matchesInString:self.string
                                     options:0
                                       range:NSMakeRange(0, self.string.length)];
    if (matches.count>0) {
        return [[NSMutableAttributedString alloc] initWithString:@"``````" attributes:self.attributes];
    }
    
    
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    //    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:self.prefixString attributes:self.attributes] atIndex:0];
    
    //    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:self.attributes] atIndex:0];
    //    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:self.attributes] atIndex:attrStr.length];
    
    return attrStr;
}

-(NSArray*)components
{
    SLKMessageContainerView* messageView = [SLKMessageContainerView new];
    messageView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.15].CGColor;
    messageView.backgroundColor = _RGBCOLOR(0xfbfaf8);
    messageView.layer.borderWidth = 0.5;
    messageView.layer.cornerRadius = 4.f;
    messageView.clipsToBounds = YES;
    [messageView displayTokens:self.subTokens];
    
    messageView.messageView.attributedText = self.attributedString;
    messageView.messageView.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);

    return @[self.prefixAttrStr, messageView];
}


@end
