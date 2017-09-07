//
//  SLKMessageCell.m
//  SLKMessage
//
//  Created by saix on 2017/9/5.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKMessageCell.h"
#import "SLKTokenParser.h"

@implementation SLKMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.layer.borderColor = [UIColor redColor].CGColor;
//    self.layer.borderWidth = 1.f;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessage:(SLKMessageModel *)message
{
    if(_message != message){
        for(UIView* subview in self.messageContainerView.subviews) {
            [subview removeFromSuperview];
        }
        
        CGRect containerRect = self.messageContainerView.frame;
        if(self.tableView){
            containerRect.size.width = self.tableView.bounds.size.width - self.messageContainerViewLC.constant - 16.f;
        }
        
        if(message.tokens) {

        }
        else {
            [self.messageContainerView displayTokens:[SLKTokenParser parseWithString:message.message attributes:nil] inRect:containerRect];
        }
        [self.messageContainerView displayTokens:message.tokens inRect:containerRect];

        [self.messageContainerView sizeToFit];
//        self.messageContainerView.backgroundColor = [UIColor blueColor];
        self.messageContainerViewHC.constant = self.messageContainerView.bounds.size.height;
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.messageContainerView  attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]
        
        _message = message;
    }
    
    
}

//-(CGFloat)height
//{
//    return 8.f + self.nameDateLabel.bounds.size.height +
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.message.height = self.bounds.size.height;
}




@end

@implementation SLKMessageModel



@end
