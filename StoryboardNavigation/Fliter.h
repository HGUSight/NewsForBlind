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
    NSRange misteg; //--> 지우기
    NSRange equalchar;
    NSRange centerdot;
    NSRange wavesymbol;
    NSRange wavesymbol2;
    NSRange corporationmark;
}

-(NSMutableString *) settext:(NSMutableString *)s1;

@end
