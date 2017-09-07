//
//  SLKMessageContainerView.m
//  SLKMessage
//
//  Created by saix on 2017/9/1.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKMessageContainerView.h"
#import "SLKToken.h"
#import "SLKMessageView.h"

@interface SLKMessageContainerView ()
@property (nonatomic, strong)SLKMessageView* messageView;
@property (nonatomic, strong) UIView* marginLine;
@property (nonatomic) CGFloat height;

@end

@implementation SLKMessageContainerView


-(CGFloat)height
{
    if(_height < 0.001) {
        [self _layoutSubviews];
        _height = self.bounds.size.height;
    }
    
    return _height;
}

-(UIView*)marginLine
{
    if(!_marginLine) {
        _marginLine = [UIView new];
        [self addSubview:_marginLine];
        _marginLine.backgroundColor = _RGBCOLOR(0xe3e4e6);//e3e4e6;
        _marginLine.hidden = YES;
        _marginLine.layer.cornerRadius = 3.f;
        _marginLine.clipsToBounds = YES;
    }
    
    return _marginLine;
}


-(SLKMessageView*)messageView
{
    if (!_messageView) {
        _messageView = [SLKMessageView new];
        [self addSubview:_messageView];
        _messageView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0);
    }
    
    return _messageView;
}


-(void)displayTokens:(NSArray<SLKToken*>*)tokens
{
    SLKMessageContainerView* curentView = self;
    
    for(SLKToken* token in tokens){
        NSArray* components = token.components;
        for(id component in components){
            if([component isKindOfClass:[UIView class]]){
                [curentView addSubview:component];
                curentView.messageView = nil;
            }
            else {
                if(((NSAttributedString*)component).length > 0) {
                    [curentView appendAttributedString:component];

                }
            }
        }
    }
}

-(void)displayTokens:(NSArray<SLKToken*>*)tokens inRect:(CGRect)rect
{
    [self displayTokens:tokens];
    self.frame = rect;
}

-(void)appendAttributedString:(NSAttributedString*)attrString
{
    
    if(self.messageView.attributedText){
        NSMutableAttributedString* newAttrString = [self.messageView.attributedText mutableCopy];
        [newAttrString appendAttributedString:attrString];
        attrString = newAttrString;
    }
    
    self.messageView.attributedText = attrString;
}


#define kMarginLineWidth 16.f
#define kVSpacing 2.f

//-(void)setFrame:(CGRect)frame
//{
////    if(CGRectEqualToRect(frame, self.frame)){
////        return;
////    }
////    else {
//        [super setFrame:frame];
//        [self sizeToFit];
////    }
//}


-(void)sizeToFit
{
//    [super sizeToFit];
    [self _layoutSubviews];
}

-(void)_layoutSubviews
{
//    for(UIView* subview in self.subviews) {
//        [subview removeFromSuperview];
//    }
    
    
//    self.layer.borderWidth = 1.f;
//    self.layer.borderColor = [UIColor blueColor].CGColor;
    
    CGFloat y = 0;
    CGFloat x = 0;
    if(!self.marginLine.hidden) {
        x = kMarginLineWidth;
    }
    for(UIView* subview in self.subviews){
        
        if(subview == self.marginLine) {
            continue;
        }
        
        if([subview isKindOfClass:[SLKMessageContainerView class]]){
            SLKMessageContainerView* containerView = (SLKMessageContainerView*)subview;
            containerView.frame = CGRectMake(x, y+kVSpacing, self.bounds.size.width-x, 0);
            [containerView sizeToFit];
        }
        else if([subview isKindOfClass:[SLKMessageView class]]){
            
            SLKMessageView* messageView = (SLKMessageView*)subview;
            messageView.frame = CGRectMake(x, y, self.bounds.size.width-x, 0);
            [messageView sizeToFit];
            
        }
        y = CGRectGetMaxY(subview.frame) + kVSpacing;
        
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
    
    if(!self.marginLine.hidden){
        self.marginLine.frame = CGRectMake(0, 0, 4, y);
    }
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat y = 0;
//    CGFloat x = 0;
//    if(!self.marginLine.hidden) {
//        x = kMarginLineWidth;
//    }
//    for(UIView* subview in self.subviews){
//        
//        if(subview == self.marginLine) {
//            continue;
//        }
//        
//        if([subview isKindOfClass:[SLKMessageContainerView class]]){
//            SLKMessageContainerView* containerView = (SLKMessageContainerView*)subview;
//            containerView.frame = CGRectMake(x, y+kVSpacing, self.bounds.size.width-x, 0);
//            [containerView layoutSubviews];
//        }
//        else if([subview isKindOfClass:[SLKMessageView class]]){
//            
//            SLKMessageView* messageView = (SLKMessageView*)subview;
//            messageView.frame = CGRectMake(x, y, self.bounds.size.width-x, 0);
//            [messageView sizeToFit];
//            
//        }
//        y = CGRectGetMaxY(subview.frame) + kVSpacing;
//        
//    }
//    
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
//    
//    if(!self.marginLine.hidden){
//        self.marginLine.frame = CGRectMake(0, 0, 4, y);
//    }
//    
//}


@end
