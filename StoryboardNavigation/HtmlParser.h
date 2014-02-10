//
//  HtmlParser.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 6..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlParser : NSObject {
    NSMutableString *linkhtmlurl;
    NSString *articlebuf;
}
@property (nonatomic, retain)NSMutableString *linkhtmlurl;
@property (nonatomic, retain)NSString *articlebuf;

-(void)sethtml:(NSMutableString *)htmllink;
//-(NSMutableString *)getNewsarticle;


@end
