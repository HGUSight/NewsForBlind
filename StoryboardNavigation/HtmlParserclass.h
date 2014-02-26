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
    NSMutableString *str1;
    NSMutableString *str2;
    NSRange text;
    NSRange text1;
    
    
}
@property (nonatomic, retain)NSMutableString *str;
@property (nonatomic, retain)NSMutableString *newstext;
@property (nonatomic, retain)NSMutableString *str1;
@property (nonatomic)NSRange text;
@property (nonatomic, retain)NSMutableString *str2;
@property (nonatomic)NSRange text1;


-(NSString*)sethtml:(NSMutableString *)htmllink;
//-(NSMutableString *)getNewsarticle;


@end
