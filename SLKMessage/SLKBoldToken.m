//
//  SLKBoldToken.m
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKBoldToken.h"
#import "SLKRegx.h"

@implementation SLKBoldToken
-(NSArray<SLKRegx*>*)subTokenRegxs
{
    return @[
             [SLKRegx boldRegx],
             [SLKRegx italicsRegx],
             [SLKRegx strikeRegx],
             [SLKRegx codeRegx],
             [SLKRegx tagRegx],
             // TODO
             //[SLKRegx quoteRegx],
             ];
}


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
    NSMutableAttributedString* finalStr = [[NSMutableAttributedString alloc] init];
    
    [attrStr enumerateAttributesInRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(NSDictionary<NSString *, id> *attrs, NSRange range, BOOL *stop){
        UIFont* font = attrs[NSFontAttributeName];
        font = font?:[SLKToken defaultAttributes][NSFontAttributeName];
        UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:font.fontName size:font.pointSize];
        [finalStr appendAttributedString:[attrStr attributedSubstringFromRange:range]];
        
        if(!fontDescriptor){
            return;
        }
        NSString *boldFontName = [[fontDescriptor fontDescriptorWithSymbolicTraits:fontDescriptor.symbolicTraits|UIFontDescriptorTraitBold].fontAttributes valueForKey:UIFontDescriptorNameAttribute];
        
        if(boldFontName.length == 0){
            return;
        }
        UIFont* newFont = [UIFont fontWithName:boldFontName size:font.pointSize];
        [finalStr addAttribute:NSFontAttributeName value:newFont range:range];
    }];
    
    [finalStr insertAttributedString:[[NSAttributedString alloc] initWithString:self.prefixString attributes:self.attributes] atIndex:0];
    return finalStr;
    
}


-(NSString*)description
{
    return [NSString stringWithFormat:@"<b>%@</b>", super.description];
}

-(NSArray*)components
{
    return @[self.attributedString];
}


@end
