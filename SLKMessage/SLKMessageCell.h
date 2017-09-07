//
//  SLKMessageCell.h
//  SLKMessage
//
//  Created by saix on 2017/9/5.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLKMessageContainerView.h"
@interface SLKMessageModel : NSObject

@property (nonatomic, copy) NSString* message;
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) NSArray* tokens;


@end
@interface SLKMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet SLKMessageContainerView *messageContainerView;
@property (nonatomic, strong) SLKMessageModel* message;
@property (nonatomic, weak) UITableView* tableView;
@property (nonatomic, readonly) CGFloat height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerViewHC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerViewLC;
@property (weak, nonatomic) IBOutlet UILabel *nameDateLabel;

@end


