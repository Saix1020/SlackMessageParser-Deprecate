//
//  NSString+SLKMessage.m
//  SLKMessage
//
//  Created by saix on 2017/9/6.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "NSString+SLKMessage.h"
#import "SLKEmojiMap.h"
#define kSLKGT @"&gt;"
#define kSLKLT @"&lt;"
#define kSLKAND @"&amp;"

@implementation NSString (SLKMessage)

-(NSString*)decodeGTLTAND
{
    NSString* result = self;
    result = [self stringByReplacingOccurrencesOfString:kSLKGT withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:kSLKLT withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:kSLKAND withString:@"&"];
    
    return result;
}

-(NSString*)decodeEmoji
{    
    NSString* emojiFile = [[SLKEmojiMap SLKEmojiMap] objectForKey:self];
    if(emojiFile.length == 0) {
        return @"";
    }
    
    emojiFile = [emojiFile stringByReplacingOccurrencesOfString:@".png" withString:@""];
    NSArray* unicodes = [emojiFile componentsSeparatedByString:@"_"];
    NSMutableData* emojiData = [NSMutableData new];
    [unicodes enumerateObjectsUsingBlock:^(NSString* unicodeString, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* hexString = [NSString stringWithFormat:@"0x%@", unicodeString];
        NSScanner *scanner=[NSScanner scannerWithString:hexString];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        [emojiData appendBytes:&temp length:sizeof(temp)];
        
    }];
    
    return  [[NSString alloc] initWithData:emojiData encoding:NSUTF32LittleEndianStringEncoding];
    
}
@end
