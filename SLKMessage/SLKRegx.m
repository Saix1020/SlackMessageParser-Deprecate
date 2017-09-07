//
//  SLKReg.m
//  SLKMessage
//
//  Created by saix on 2017/8/23.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKRegx.h"
#import "SLKToken.h"
#import "SLKTokenFactory.h"

const NSString* kSLKBoldRegx = @"(^|\\s|[/\\?\\.,\\-!\\^;:{(\\[%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\"])\\*(.*?\\S *)?\\*(?=$|\\s|[/\\?\\.,'\\-!\\^;:})\\]%$~{\\[<#+=\\u2000-\\u206F\\u2E00-\\u2E7F\u2026\"\\uE022])";
const NSString* kSLKItalicsRegx = @"(?!:.+:)(^|\\s|[/\\?\\.,\\-!\\^;:{(\\[%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\"])_(.*?\\S *)?_(?=$|\\s|[/\\?\\.,'\\-!\\^;:})\\]%$~{\\[<#+=\\u2000-\\u206F\\u2E00-\\u2E7F\u2026\"\\uE022])";
const NSString* kSLKStrikeRegx = @"(^|\\s|[/\\?\\.,\\-!\\^;:{(\\[%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\"])~(.*? *\\S)?~(?=$|\\s|[/\\?\\.,'\\-!\\^;:})\\]%$~{\\[<#+=\\u2000-\\u206F\\u2E00-\\u2E7F\u2026\"\\uE022])";

const NSString* kSLKPreRegx = @"(^|\\s|[_*\\?\\.,\\-!\\^;:{(\\[%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\"])```([\\s\\S]*?)?```(?=$|\\s|[_*\\?\\.,\\-!\\^;:})\\]%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\u2026\"])";
const NSString* kSLKCodeRegx = @"(^|\\s|[\\*\\\\/\\?\\.,\\-!\\^;:{(\\[%$#+=\\u2000-\\u206F\\u2E00-\\u2E7F\"])`([^`\n]*?\\S *)?`";

// for Dpb, please Emoticons
const NSString* kSLKQuoteRegx = @"(^|\n)&gt;(?![\\W_](?:&lt;|&gt;|[\\|/\\\\\\[\\]{}\\(\\)Dpb](?=\\s|$)))(([^\n]*)(\n&gt;[^\n]*)*)";
const NSString* kSLKLongQuoteRegx = @"(^|\n)&gt;&gt;&gt;([\\s\\S]*$)";

const NSString* kSLKEmojiRegx = @"(:[a-zA-Z0-9-_+]+:)(:skin-tone-[2-6]:)?";
// Jumbomoji means large emoji
const NSString* kSLKJumbomojiRegx = @"^(:[a-zA-Z0-9-_+]+:(:skin-tone-[2-6]:)*(?:\\u200D|(\\u200D(\u2640|\u2640\ufe0f|\u2642|\u2642\ufe0f)))?(\\s)*){1,23}$";
const NSString* kSLKUrlRegx = @"((ftp|http|https|file)://|\\bw{3}\\.)[a-z0-9\\-\\.]+[a-z]+(:[a-z0-9]*)?/?([@a-z0-9\\-\\._\\?,'\\(\\)\\*/\\\\\\+&amp;%:!$#=~*])*";

const NSString* kSLKTagRegx = @"<(.*?)>";

const NSString* kSLKGT = @"&gt;";
const NSString* kSLKLT = @"&lt;";
const NSString* kSLKAND = @"&amp;";



@interface SLKRegx ()
@property (nonatomic, strong) NSRegularExpression* regx;
@property (nonatomic) SLKTokenType type;

@end

@implementation SLKRegx

-(instancetype)initWithRegxStr:(NSString*)regxStr
{
    self = [super init];
    if(self) {
        self.regx = [NSRegularExpression regularExpressionWithPattern:regxStr
                                                              options:NSRegularExpressionCaseInsensitive
                                                                error:nil];
        
    }
    
    return self;

}

-(instancetype)initWithRegxStr:(NSString*)regxStr type:(SLKTokenType)type
{
    self = [super init];
    if(self) {
        
        if(type == kSLKUrl) {
            self.regx = [NSRegularExpression regularExpressionWithPattern:regxStr
                                                                  options:NSRegularExpressionCaseInsensitive
                                                                    error:nil];

        }
        else {
            self.regx = [NSRegularExpression regularExpressionWithPattern:regxStr
                                                                  options:0
                                                                    error:nil];

        }
        self.type = type;
        
    }
    
    return self;
    
}



-(BOOL)matched:(NSString *)string
{
    if(string.length == 0){
        return NO;
    }
    
    NSArray *matches = [self.regx matchesInString:string
                                          options:0
                                            range:NSMakeRange(0, string.length)];
    
    return matches.count > 0;
}


-(NSArray<SLKToken*>*)matchs:(NSString*)string
{
    
    return [self matchs:string attributes:[SLKToken defaultAttributes]];
    
}

-(NSArray<SLKToken*>*)matchs:(NSString*)string attributes:(NSDictionary*)attrs
{
    NSMutableArray<SLKToken*>* tokens = [[NSMutableArray alloc] init];
    
    NSArray *matches = [self.regx matchesInString:string
                                          options:0
                                            range:NSMakeRange(0, string.length)];
    
    
    
    
    
    for (NSTextCheckingResult *match in matches) {
        [tokens addObject:[SLKTokenFactory createTokenWithString:string textCheckingResult:match attribuites:attrs regx:self]];
    }
    
    return tokens;
}

-(SLKToken*)matchsFirst:(NSString*)string attributes:(NSDictionary*)attrs
{
    NSTextCheckingResult *match = [self.regx firstMatchInString:string
                                          options:0
                                            range:NSMakeRange(0, string.length)];
    
    SLKToken* token = nil;
    if(match) {
        token = [SLKTokenFactory createTokenWithString:string textCheckingResult:match attribuites:attrs regx:self];
    }
    
    return token;
}

-(SLKToken*)matchsFirst:(NSString*)string
{
    return [self matchsFirst:string attributes:[SLKToken defaultAttributes]];
}


#define __REGX_MAKE(reg, Reg) \
    +(SLKRegx*)reg##Regx \
    {\
        return [[SLKRegx alloc] initWithRegxStr:[kSLK##Reg##Regx copy] type:kSLK##Reg];\
    }\

//+(SLKRegx*)codeRegx;
//+(SLKRegx*)preRegx;
//+(SLKRegx*)quoteRegx;
//+(SLKRegx*)emojiRegx;
//+(SLKRegx*)jumbomojiRegx;
//+(SLKRegx*)longQuoteRegx;
//+(SLKRegx*)urlRegx;
//+(SLKRegx*)tagRegx;


__REGX_MAKE(bold, Bold);
__REGX_MAKE(italics, Italics);
__REGX_MAKE(strike, Strike);
__REGX_MAKE(quote, Quote);
__REGX_MAKE(pre, Pre);
__REGX_MAKE(emoji, Emoji);
__REGX_MAKE(jumbomoji, Jumbomoji);
__REGX_MAKE(longQuote, LongQuote);
__REGX_MAKE(url, Url);
__REGX_MAKE(tag, Tag);
__REGX_MAKE(code, Code);
//+(SLKRegx*)boldRegx
//{
//    return [[SLKRegx alloc] initWithRegxStr:[kSLKBoldRegx copy] type:kSLKBold];
//}
//+(SLKRegx*)italicsRegx
//{
//    return [[SLKRegx alloc] initWithRegxStr:[kSLKItalicsRegx copy] type:kSLKItalics];
//
//}
//+(SLKRegx*)strikeRegx
//{
//    return [[SLKRegx alloc] initWithRegxStr:[kSLKStrikeRegx copy] type:kSLKStrike];
//
//}

@end
