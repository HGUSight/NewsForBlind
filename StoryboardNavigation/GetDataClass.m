//
//  GetDataClass.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 5. 13..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "GetDataClass.h"

@implementation GetDataClass

- (void)getdataclass {
    
    linkarr=[[NSMutableArray alloc]init];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1425192933.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855024.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855066.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855033.xml"]; //(?)
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855029.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855037.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855016.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855040.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855052.xml"]; 
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855056.xml"];
    [linkarr addObject:@"http://ph.kyongbuk.co.kr/rss/1424855049.xml"];
    
    receiveData = [[NSMutableData alloc] init];
    totaldataarray=[[NSMutableArray alloc]init];
    
    for(int i=0;i<linkarr.count;i++) {
        
        urlstring = linkarr[i];
        
        
        xmlConnection = [[NSURLConnection alloc]
                         initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]]
                         delegate:self];
        
        if (xmlConnection == nil)
            NSLog(@"Connect error");
        
        else
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }
    
    
}

#pragma mark URLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Receive: %@, %@, %lld",
		  [response URL],
		  [response MIMEType],
		  [response expectedContentLength]);
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", [error localizedDescription]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receiveData appendData:data];
    [totaldataarray addObject:receiveData];
    //NSLog(@"receicedata=%@",receiveData);
    receiveData = [[NSMutableData alloc] init];
   
    
  }

@end
