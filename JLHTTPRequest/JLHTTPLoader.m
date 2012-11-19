//
//  JLHTTPLoader.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPLoader.h"
#import "JLHTTPRequest.h"
#import "JLHTTPResponse.h"

@implementation JLHTTPLoader

@synthesize delegate;

- (id)init
{
	self = [super init];
	
	queue = [[NSMutableArray alloc] init];
	responseData = [[NSMutableData alloc] init];
	
	return self;
}

- (void)addRequest:(JLHTTPRequest *)request
{
	[queue addObject:request];
}

- (void)startLoading
{
	if( loading || queue.count == 0 ) return;

	JLHTTPRequest *request = [queue objectAtIndex:0];
//	if( [delegate responseToSelector:] [delegate shouldLoadWithToken:request] )
	{
		[[[NSURLConnection alloc] initWithRequest:request.URLRequest delegate:self] autorelease];
		[request release];
		loading = YES;
	}
}


#pragma mark -
#pragma mark NSURLConnection

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)cancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	statusCode = httpResponse.statusCode;
	responseHeader = [httpResponse.allHeaderFields retain];
	responseData.length = 0;
	
//	_cookies = [[NSHTTPCookie cookiesWithResponseHeaderFields:responseHeader forURL:response.URL] retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if( queue.count == 0 )
	{
		NSLog( @"Loading queue is empty!" );
		return;
	}
	
	JLHTTPRequest *request = [[queue objectAtIndex:0] retain];
	[queue removeObjectAtIndex:0];
	
	JLHTTPResponse *response = [[JLHTTPResponse alloc] init];	
	response.statusCode = statusCode;
	response.headers = responseHeader;
	response.body = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[delegate loaderDidFinishLoading:response];
	[request release];
	
	statusCode = 0;
	responseHeader = nil;
	[responseHeader release];
	
	[self startLoading];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog( @"Loading Error : %@", error );
//	loading = NO;
}

@end
