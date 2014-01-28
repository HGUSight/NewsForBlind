//
//  Fliter.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fliter : NSObject {
    
    NSRange teg;
    NSRange r;
    NSRange hanja;
    NSRange emptyfield;
}

-(NSMutableString *) settext:(NSMutableString *)s1;

@end
