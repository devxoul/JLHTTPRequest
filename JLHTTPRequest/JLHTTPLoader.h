//
//  JLHTTPLoader.h
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLHTTPRequest;
@class JLHTTPResponse;
@protocol JLHTTPLoaderDelegate;

@interface JLHTTPLoader : NSObject
{
	id<JLHTTPLoaderDelegate> delegate;
	NSMutableArray *queue;
	BOOL loading;
	
	NSInteger statusCode;
	NSDictionary *responseHeader;
	NSMutableData *responseData;
}

@property (retain, nonatomic) id<JLHTTPLoaderDelegate> delegate;

- (void)addRequest:(JLHTTPRequest *)request;
- (void)startLoading;

@end



@protocol JLHTTPLoaderDelegate

//@optional
//- (BOOL)shouldLoadWithToken:(JLHTTPRequest *)token;

@required
- (void)loaderDidFinishLoading:(JLHTTPResponse *)response;

@end