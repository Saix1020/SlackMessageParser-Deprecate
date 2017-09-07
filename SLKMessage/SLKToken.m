//
//  SLKToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/23.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKToken.h"
#import "UIFont+SLKMessage.h"
#import "SLKRegx.h"
#import "SLKMessageView.h"
#import "NSString+SLKMessage.h"

@interface SLKToken()


@property (nonatomic, strong) SLKRegx* regx;
@property (nonatomic, copy) NSString* string;
@property (nonatomic, copy) NSDictionary* attributes;
@property (nonatomic, strong) NSAttributedString* attributedString;

@property (nonatomic, strong) NSArray<SLKToken*>* subTokens;
@property (nonatomic, strong) NSTextCheckingResult* match;
@property (nonatomic, readonly) UIFont* fontInAttributes;
@property (nonatomic, strong) SLKMessageContainerView* containerView;

//@property (nonatomic, strong) UITextView* containerView;

@end

@implementation SLKToken

-(instancetype)initWithString:(NSString*)string
           textCheckingResult:(NSTextCheckingResult*)match
                  attribuites:(NSDictionary*)attributes
                         regx:(SLKRegx *)regx
{
    
    self = [super init];
    
    if (self) {
        self.match = match;
        self.regx = regx;
        self.attributes = attributes? attributes:[SLKToken defaultAttributes];
        self.string = string;
    }
    
    return self;
}

-(instancetype)initWithString:(NSString*)string
           textCheckingResult:(NSTextCheckingResult*)match
                         regx:(SLKRegx *)regx
{
    return [self initWithString:string
             textCheckingResult:match
                    attribuites:nil
                           regx:regx];
}

-(UIFont*)fontInAttributes
{
    UIFont* font = self.attributes[NSFontAttributeName];
    font = font?:[SLKToken defaultAttributes][NSFontAttributeName];
    
    return font;
}

-(NSString*)matchedString
{
    
    if(self.regx.type == kSLKText){
        
        if(self.prevToken
           && ( self.prevToken.regx.type == kSLKQuote
               || self.prevToken.regx.type == kSLKLongQuote
               || self.prevToken.regx.type == kSLKPre)){
               if([self.string hasPrefix:@"\n"]){
                   return [[self.string substringFromIndex:1] decodeGTLTAND];
               }
           }
        
        return [self.string decodeGTLTAND];
    }
    else {
        return [self.string substringWithRange:self.match.range];
    }
}


+(NSDictionary*)defaultAttributes
{
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:14.5]
             };
}


-(NSArray<SLKToken*>*)subTokens
{
    if(_subTokens.count>0){
        return _subTokens;
    }
    
    _subTokens = [self parseSubTokens];
    
    return _subTokens;
}

-(NSArray<SLKToken*>*)parseSubTokens
{
    return nil;
}

-(NSAttributedString*)attributedString
{
    
    if(!_attributedString){
        _attributedString = [self encodeToAttributedString];
    }
    
    return _attributedString;
    
}

-(NSAttributedString*)prefixAttrStr
{
    NSString* str = self.prefixString;
    str = str?:@"";
    return [[NSAttributedString alloc] initWithString:str attributes:self.attributes];
}

-(NSAttributedString*)suffixAttrStr
{
    NSString* str = self.suffixString;
    str = str?:@"";
    return [[NSAttributedString alloc] initWithString:str attributes:self.attributes];
}


-(NSMutableAttributedString*)encodeToAttributedString
{
    NSString* matchedString = self.matchedString;
    
    NSMutableAttributedString* finalString = [[NSMutableAttributedString alloc] initWithString:matchedString attributes:self.attributes];
    [finalString addAttribute:@"kSLKTokenType" value:@(self.regx.type) range:NSMakeRange(0, finalString.length)];
    
    return finalString;
}

-(NSString*)description
{
    NSMutableString* finalString = [[NSMutableString alloc] init];
    [finalString appendString:self.attributedString.string];
    return finalString;
}


-(NSArray*)components
{
    return @[self.attributedString];
}


@end
