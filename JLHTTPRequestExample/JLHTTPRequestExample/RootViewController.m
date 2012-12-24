//
//  RootViewController.m
//  JLHTTPRequestExample
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "RootViewController.h"
#import "JLHTTPGETRequest.h"
#import "JLHTTPFormEncodedRequest.h"
#import "JLHTTPResponse.h"

@implementation RootViewController

- (id)init
{
	self = [super init];
	
	JLHTTPLoader *loader = [[JLHTTPLoader alloc] init];
	loader.delegate = self;
	
	JLHTTPGETRequest *req = [[JLHTTPGETRequest alloc] init];
	req.url = @"http://www.fanpple.com:8080/Fanpple/APIGateway";
	[req setParam:@"login" forKey:@"api_name"];
	[req setParam:@"devxoul@gmail.com" forKey:@"id"];
	[req setParam:@"joyfloux" forKey:@"pw"];
	[loader addRequest:req];
	
	JLHTTPGETRequest *getUserReq = [[JLHTTPGETRequest alloc] init];
	getUserReq.url = @"http://www.fanpple.com:8080/Fanpple/APIGateway";
	[getUserReq setParam:@"getUser" forKey:@"api_name"];
	[getUserReq setParam:@"devxoul@gmail.com" forKey:@"uid"];
	[loader addRequest:getUserReq];
	
	JLHTTPFormEncodedRequest *getContentsReq = [[JLHTTPFormEncodedRequest alloc] init];
	getContentsReq.url = @"http://www.fanpple.com:8080/Fanpple/APIGateway";
	getContentsReq.method = @"POST";
	[getContentsReq setParam:@"getContents" forKey:@"api_name"];
	[getContentsReq setParam:@"C" forKey:@"curView"];
	[getContentsReq setParam:@"devxoul@gmail.com" forKey:@"curUId"];
	[getContentsReq setParam:@"" forKey:@"curSearchKeyword"];
	[getContentsReq setParam:@"DT" forKey:@"curSortOption"];
	[getContentsReq setParam:@"0" forKey:@"curPosition"];
	[loader addRequest:getContentsReq];
	
	[loader startLoading];
	
	NSLog( @"load" );
	
	return self;
}

- (void)loaderDidFinishLoading:(JLHTTPResponse *)response
{
	NSLog( @"Status Code : %d", response.statusCode );
	NSLog( @"Response Headers : %@", response.headers );
	NSLog( @"Response Body : %@", response.body );
	NSLog( @"------------------------------------------------------" );
}


@end
