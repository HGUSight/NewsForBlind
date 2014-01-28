//
//  News.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 28..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject{
	
	NSMutableString *title;	//Same name as the Entity Name.
	NSMutableString *description;	//Same name as the Entity Name.
    NSMutableString *link;
    NSMutableString *category;
    NSMutableString *pubData;

}

@property (nonatomic, retain) NSMutableString *title;
@property (nonatomic, retain) NSMutableString *description;
@property (nonatomic, retain) NSMutableString *link;
@property (nonatomic, retain) NSMutableString *pubData;
@property (nonatomic, retain) NSMutableString *category;



@end
