//
//  SLKCodeToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKCodeToken.h"

@implementation SLKCodeToken
-(NSString*)matchedString
{
    NSRange matchedRang = [self.match rangeAtIndex:2];
    return [NSString stringWithFormat:@" %@ ", [self.string substringWithRange:matchedRang]];
}

-(NSString*)prefixString
{
    NSRange prefixRang = [self.match rangeAtIndex:1];
    return [self.string substringWithRange:prefixRang];
}

-(NSMutableAttributedString*)encodeToAttributedString
{
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"^`{0,2}$"
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:nil];
    
    NSArray *matches = [regx matchesInString:self.matchedString
                                     options:0
                                       range:NSMakeRange(0, self.matchedString.length)];
    if (matches.count>0) {
        return [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"`%@`", self.matchedString] attributes:self.attributes];
    }
    
    
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    [attrStr addAttribute:@"kSLKCodeAttribute" value:@(1) range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:_RGBCOLOR(0xcc2255) range:NSMakeRange(0, attrStr.length)];
    //    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.prefixString] attributes:self.attributes] atIndex:0];
    //
    //    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:self.prefixString attributes:self.attributes] atIndex:0];
    
//    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:self.attributes] atIndex:0];
//    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:self.attributes] atIndex:attrStr.length];
    
    return attrStr;

}

-(NSArray*)components
{
    return @[self.prefixAttrStr, self.attributedString];
}

@end
