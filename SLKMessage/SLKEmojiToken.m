//
//  SLKEmojiToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/28.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKEmojiToken.h"
#import "NSString+SLKMessage.h"

@implementation SLKEmojiToken

-(NSString*)matchedString
{
    NSRange matchedRang = [self.match rangeAtIndex:1];
    
    NSString* emojiString = [self.string substringWithRange:matchedRang];
    emojiString = [emojiString substringWithRange:NSMakeRange(1, emojiString.length-2)];
    emojiString = [emojiString decodeEmoji];
    
    return emojiString;
}

//-(NSMutableAttributedString*)encodeToAttributedString
//{
//    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
//    return attrStr;
//}
@end
