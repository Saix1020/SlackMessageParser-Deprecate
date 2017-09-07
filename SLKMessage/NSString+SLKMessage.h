//
//  NSString+SLKMessage.h
//  SLKMessage
//
//  Created by saix on 2017/9/6.
//  Copyright © 2017年 sai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SLKMessage)

-(NSString*)decodeGTLTAND;
-(NSString*)encodeGTLTAND;

-(NSString*)decodeEmoji;
-(NSString*)encodeEmoji;


@end
