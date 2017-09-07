//
//  SLKURLProtocol.m
//  SLKMessage
//
//  Created by saix on 2017/9/5.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKURLProtocol.h"

@interface NSURL (SLKURLProtocol)

@property (nonatomic, readonly) NSString* tagId;

@end

@implementation NSURL (SLKURLProtocol)
-(NSString *)tagId
{
    NSString *tagId = nil;
    if ([self.scheme.lowercaseString isEqualToString:kSLKURLProtocolTagLinkScheme])
    {
        tagId = self.resourceSpecifier;
    }
    return tagId;
}
@end


@implementation SLKURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    BOOL canInit = NO;
    NSString *contentId = request.URL.tagId;
    if(contentId)
    {
        return YES;
    }
    return canInit;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)request
{
    return request;
}

/**
 * This is the entry point to start loading an attachment
 */
- (void)startLoading
{
    NSLog(@"display %@", self.request.URL.tagId);
}

/**
 * Cancels the load of the attachment if it's started
 */
- (void)stopLoading
{
    
    
}



@end
