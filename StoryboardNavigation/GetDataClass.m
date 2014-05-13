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
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/headline.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/politics.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/self-government.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/international.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/national.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/economy.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/culture.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/regionnews.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/sportentertainment.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/editorials.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/special.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/people.xml"];
    
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
