//
//  SLKJumbomojiToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/28.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKJumbomojiToken.h"
#import "NSString+SLKMessage.h"
#import "SLKRegx.h"

@implementation SLKJumbomojiToken
//const NSString* kSLKJumbomojiRegx = @"^(:[a-zA-Z0-9-_+]+:(:skin-tone-[2-6]:)*(?:\\u200D|(\\u200D(\u2640|\u2640\ufe0f|\u2642|\u2642\ufe0f)))?(\\s)*){1,23}$";

-(NSString*)matchedString
{
    // TODO 
    NSString* string = self.string;
    NSMutableString* finalEmojis = [NSMutableString new];
    NSRegularExpression* regx =  [NSRegularExpression regularExpressionWithPattern:@"^((:[a-zA-Z0-9-_+]+:)(:skin-tone-[2-6]:)*((\\u200D(\u2640|\u2640\ufe0f|\u2642|\u2642\ufe0f))|\\u200D)?(\\s)*)"
                                                                           options:0
                                                                             error:nil];
    while(string.length>0){
        NSTextCheckingResult* match = [regx firstMatchInString:string
                                                       options:0
                                                         range:NSMakeRange(0, string.length)];
        if(!match) {
            [finalEmojis appendString:string];
            break;
        }
        NSRange matchedRange = match.range;
        NSString* matchedString = [string substringWithRange:matchedRange];
        string = [string substringFromIndex:matchedRange.location+matchedRange.length];

        NSRange emojiRange = [match rangeAtIndex:2];
        NSRange skinStonRange = [match rangeAtIndex:3];
        NSRange unicodesRange = [match rangeAtIndex:4];
        NSRange spacesRange = [match rangeAtIndex:7];
        NSString* emojiString;
        NSString* skinStonString = @"";
        NSString* unicodesString = @"";
        NSString* spacesString = @"";
        
#define _GETSTRING(name) \
do { \
    if(name##Range.location != NSNotFound) { \
        name##String = [matchedString substringWithRange:name##Range];\
    } \
}\
while(0)
        
        _GETSTRING(emoji);
        _GETSTRING(skinSton);
        _GETSTRING(unicodes);
        _GETSTRING(spaces);
        
        
        emojiString = [emojiString substringWithRange:NSMakeRange(1, emojiString.length-2)];
        [finalEmojis appendString:[emojiString decodeEmoji]];
        [finalEmojis appendString:unicodesString];
        [finalEmojis appendString:spacesString];

    }
    
    return finalEmojis;
}


-(NSMutableAttributedString*)encodeToAttributedString
{
    NSMutableAttributedString* attrStr = [super encodeToAttributedString];
    
    UIFont* font = [UIFont systemFontOfSize:40.f];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrStr.length)];
    
    
    return attrStr;
}

@end
