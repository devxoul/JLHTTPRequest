//
//  JLHTTPGETRequest.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPGETRequest.h"

@implementation JLHTTPGETRequest

- (NSURLRequest *)URLRequest
{
	NSString *paramString = @"";
	if( params )
	{
		for( id key in params )
			paramString = [paramString stringByAppendingFormat:@"%@=%@&", key, [params objectForKey:key]];
		
		paramString = [paramString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	
	NSLog( @"%@", [url stringByAppendingFormat:@"?%@", paramString] );
	return [[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingFormat:@"?%@", paramString]]] retain];
}

@end