//
//  SLKUrlToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/28.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKUrlToken.h"

@implementation SLKUrlToken



-(NSMutableAttributedString*)encodeToAttributedString
{
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    
    [attrStr addAttribute:NSLinkAttributeName value:@"http://www.google.com" range:NSMakeRange(0, attrStr.length)];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"<url>" attributes:self.attributes] atIndex:0];
    [attrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"</url>" attributes:self.attributes] atIndex:attrStr.length];
    
    return attrStr;
}
@end
