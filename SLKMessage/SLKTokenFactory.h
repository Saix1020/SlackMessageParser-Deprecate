//
//  SLKTokenFactory.h
//  SLKMessage
//
//  Created by saix on 2017/8/24.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLKToken;
@class SLKRegx;

@interface SLKTokenFactory : NSObject

+(SLKToken*)createTokenWithString:(NSString*)string
                   textCheckingResult:(NSTextCheckingResult*)match
                          attribuites:(NSDictionary*)attributes
                                 regx:(SLKRegx *)regx;

@end
