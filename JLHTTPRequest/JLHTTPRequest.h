//
//  JLHTTPRequest.h
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLHTTPRequest : NSObject
{
	NSString *url;
	NSString *method;
	NSMutableDictionary *params;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *method;

- (void)setParam:(id)value forKey:(id<NSCopying>)key;
//- (void)setKey:(id<NSCopying>)key andParam:(id)value;
- (NSURLRequest *)URLRequest;

@end
