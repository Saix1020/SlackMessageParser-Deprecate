//
//  SLKTokenHasSubTokens.h
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKToken.h"
#import "SLKMessageContainerView.h"
@class SLKRegx;
@interface SLKTokenHasSubTokens : SLKToken

@property (nonatomic, readonly) NSArray<SLKRegx*>* subTokenRegxs;

@end
