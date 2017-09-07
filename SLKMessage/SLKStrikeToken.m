//
//  SLKStrikeToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKStrikeToken.h"

@implementation SLKStrikeToken
-(NSString*)matchedString
{
    NSRange matchedRang = [self.match rangeAtIndex:2];
    return [self.string substringWithRange:matchedRang];
}

-(NSString*)prefixString
{
    NSRange prefixRang = [self.match rangeAtIndex:1];
    return [self.string substringWithRange:prefixRang];
}


-(NSMutableAttributedString*)encodeToAttributedString
{
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    [attrStr addAttribute:NSBaselineOffsetAttributeName value:@0 range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, attrStr.length)];
    
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:self.prefixString attributes:self.attributes] atIndex:0];
    
    return attrStr;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"<s>%@</s>", super.description];
}

-(NSArray*)components
{
    return @[self.attributedString];
}

@end
