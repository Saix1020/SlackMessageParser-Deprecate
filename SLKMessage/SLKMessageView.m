//
//  SLKMessageView.m
//  SLKMessage
//
//  Created by saix on 2017/8/31.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKMessageView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "SLKToken.h"

@implementation SLKMessageView
//+(id)UIColorFromRGB:(NSUInteger) rgbValue
//{
//    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
//}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.editable = NO;
        self.delegate = self;
        self.editable = NO;
        self.scrollEnabled = NO;
//        self.selectable = NO;
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(2, 0, 0, 0);
    }
    
    return self;
}


-(void)drawRect:(CGRect)rect
{
    if(!self.attributedText) {
        [super drawRect:rect];
        return;
    }
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *, id> *attrs, NSRange range, BOOL *stop){
        
        UITextPosition* beginning = self.beginningOfDocument;
        UITextPosition* start = [self positionFromPosition:beginning offset:range.location];//textView.positionFromPosition(beginning, offset: range.location)!
        UITextPosition* end = [self positionFromPosition:beginning offset:range.location+range.length];//textView.positionFromPosition(start, offset: range.length)!
        
        UITextRange* textRange = [self textRangeFromPosition:start toPosition:end];
//        CGRect rect = [self firstRectForRange:textRange];
        NSArray* selectionRectsForRange = [self selectionRectsForRange:textRange];
        //        [self setSelectedRange:range];
        
        if(attrs[@"kSLKCodeAttribute"]){
            [self drawBackgroundForCodeRectIn:selectionRectsForRange];
        }
//        else if(attrs[@"kSLKPreAttribute"]){
//            [self drawBackgroundForPreRectIn:selectionRectsForRange];
//        }
        
        
        
        

        
    }];
}

-(void)drawBackgroundForCodeRectIn:(NSArray*)rects
{
    for(UITextSelectionRect* rect in rects) {
        if(ceil(rect.rect.size.width) == 0 || ceil(rect.rect.size.height) == 0){
            
        }
        else {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            [_RGBCOLOR(0xf7f7f9) setFill]; //f7f7f9
            CGRect rectx = rect.rect;
//            rectx.size.height -= 4;
//            rectx.origin.y += 2;
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rectx cornerRadius:2];
            CGContextSetStrokeColorWithColor(context, _RGBCOLOR(0xe1e1e8).CGColor); //e1e1e8
            
            [bezierPath stroke];
            [bezierPath fill];
            CGContextRestoreGState(context);
            
            
        }
    }
}

-(void)drawBackgroundForPreRectIn:(NSArray*)rects
{
    CGRect rect = CGRectZero;
    
    NSMutableArray* validRects = [@[] mutableCopy];

    for(UITextSelectionRect* rect in rects) {
        if(ceil(rect.rect.size.width) == 0 || ceil(rect.rect.size.height) == 0){
            
        }
        else {
            
            [validRects addObject:rect];
            
            
        }
    }
    
    UITextSelectionRect* firstRect = validRects.firstObject;
    UITextSelectionRect* lastRect = validRects.lastObject;
    rect.origin.x = 0.5f;
    rect.origin.y = firstRect.rect.origin.y;
    
    rect.size.height = lastRect.rect.origin.y - rect.origin.y + lastRect.rect.size.height - 4;
    rect.size.width = self.bounds.size.width-1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [_RGBCOLOR(0xfbfaf8) setFill];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.15].CGColor);
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if([URL.scheme.lowercaseString isEqualToString:kSLKURLProtocolTagLinkScheme.lowercaseString]) {
        NSLog(@"tag %@ clicked!", URL.resourceSpecifier);
        return NO;

    }
    return YES;
}


@end
