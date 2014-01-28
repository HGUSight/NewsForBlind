//
//  News.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 28..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize title,description,link,pubData,category;

- (void) dealloc {
	
	[description release];
	[title release];
    [link release];
    [pubData release];
    [category release];
    
	[super dealloc];
}


@end
