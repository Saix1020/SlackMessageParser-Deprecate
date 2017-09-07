//
//  UIFont+SLKMessage.m
//  SLKMessage
//
//  Created by saix on 2017/8/23.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "UIFont+SLKMessage.h"

@implementation UIFont (SLKMessage)

-(UIFont*)boldFont
{
    UIFontDescriptor *fontDescriptor = [[[UIFontDescriptor alloc] init] fontDescriptorWithFamily:self.familyName];
    
    if(!fontDescriptor){
        return self;
    }
    
    NSString *boldFontName = [[fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold].fontAttributes valueForKey:UIFontDescriptorNameAttribute];
    
    if(boldFontName.length == 0){
        return self;
    }
    
    return [UIFont fontWithName:boldFontName size:self.pointSize];
}

-(UIFont*)italicsFont
{
    UIFontDescriptor *fontDescriptor = [[[UIFontDescriptor alloc] init] fontDescriptorWithFamily:self.familyName];
    
    if(!fontDescriptor){
        return self;
    }
    
    NSString *boldFontName = [[fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic].fontAttributes valueForKey:UIFontDescriptorNameAttribute];
    
    if(boldFontName.length == 0){
        return self;
    }
    
    return [UIFont fontWithName:boldFontName size:self.pointSize];
}


-(UIFont*)boldAndItalicsFont
{
    UIFontDescriptor *fontDescriptor = [[[UIFontDescriptor alloc] init] fontDescriptorWithFamily:self.familyName];
    
    if(!fontDescriptor){
        return self;
    }
    
    NSString *boldFontName = [[fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic|UIFontDescriptorTraitBold].fontAttributes valueForKey:UIFontDescriptorNameAttribute];
    
    if(boldFontName.length == 0){
        return self;
    }
    
    return [UIFont fontWithName:boldFontName size:self.pointSize];
}

@end
