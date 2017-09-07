//
//  SLKTagToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKTagToken.h"
#import "SLKURLProtocol.h"

@implementation SLKTagToken
-(NSString*)matchedString
{
    NSRange matchedRang = [self.match rangeAtIndex:1];
    return [self.string substringWithRange:matchedRang];
}



-(NSMutableAttributedString*)encodeToAttributedString
{
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, attrStr.length)];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@", kSLKURLProtocolTagLinkScheme, self.matchedString]];
    [attrStr addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, attrStr.length)];
    
    return attrStr;
}
@end
