//
//  HtmlParser.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 6..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Fliter;

@interface HtmlParserclass : NSObject{
    Fliter *fliter;
    NSMutableString *str;
    NSMutableString *newstext;
    
}
@property (nonatomic, retain)NSMutableString *str;
@property (nonatomic, retain)NSMutableString *newstext;

-(NSString*)sethtml:(NSMutableString *)htmllink;
//-(NSMutableString *)getNewsarticle;


@end
