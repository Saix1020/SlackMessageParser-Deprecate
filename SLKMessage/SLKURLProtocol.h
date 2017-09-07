//
//  SLKURLProtocol.h
//  SLKMessage
//
//  Created by saix on 2017/9/5.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSLKURLProtocolTagLinkScheme @"SLKTag"

@interface SLKURLProtocol : NSURLProtocol

@property (nonatomic, readonly) NSString* tagId;


@end

