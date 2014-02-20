//
//  Fliter.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "Fliter.h"

@implementation Fliter


- (NSMutableString *) settext:(NSMutableString *)s1 {
    
    for(int i = 0; i < [s1 length]; i++) {
        //findout the range with "sub" string
        teg = [s1 rangeOfString:@"<[^<]*>" options:NSRegularExpressionSearch];
        a= [s1 rangeOfString:@"{[^{]*}" options:NSRegularExpressionSearch];
        //r = [s1 rangeOfString:@"[[:punct:]]" options:NSRegularExpressionSearch];
       // hanja=[s1 rangeOfString:@"^0x{2E80}-0x{2EFF}0x{31C0}-0x{31EF}0x{3200}-0x{32FF}0x{3400}-0x{4DBF}0x{4E00}-0x{9FBF}0x{F900}-0x{FAFF}0x{20000}-0x{2A6DF}//0x{2F800}-0x{2FA1F}" options:NSRegularExpressionSearch];
        //emptyfield=[s1 rangeOfString:@"nbsp" options:NSRegularExpressionSearch];

        
        if(teg.location != NSNotFound) {
            //Delete the characters in that range
            [s1 deleteCharactersInRange:teg];
           
        }else if(a.location != NSNotFound) {
            
             [s1 deleteCharactersInRange:a];
        
       // }else if(hanja.location != NSNotFound) {
            
       //     [s1 deleteCharactersInRange:hanja];
            
       // }else if(emptyfield.location != NSNotFound) {
            
       //     [s1 deleteCharactersInRange:emptyfield];
            
        }
        else {
            //break the loop if sub string not found as there is no more recurrence.
            break;
        }
    
    }
    
    return s1;

}

@end
